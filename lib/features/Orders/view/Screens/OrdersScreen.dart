import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/constants/app_constants.dart';
import 'package:start/features/Orders/Bloc/bloc/orders_bloc.dart';
import 'package:start/features/Orders/Models/DeliveryOrdersModel.dart'
    as delivery_models;
import 'package:start/features/Orders/Models/OrdersSvheduleModel.dart'
    as schedule_models;

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late OrdersBloc _ordersBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _ordersLoaded = false;
  bool _schedulesLoaded = false;

  Color get shimmerBaseColor => Theme.of(context).brightness == Brightness.dark
      ? Colors.grey[800]!
      : Colors.grey[300]!;

  Color get shimmerHighlightColor =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[700]!
          : Colors.grey[100]!;

  @override
  void initState() {
    super.initState();
    _ordersBloc = OrdersBloc(client: NetworkApiServiceHttp());
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) return;

    if (_tabController.index == 0 && !_ordersLoaded) {
      _ordersBloc.add(GetOrdersEvent());
    } else if (_tabController.index == 1 && !_schedulesLoaded) {
      _ordersBloc.add(GetOrdersScheduleEvent());
    }
  }

  void _handleRefresh() {
    if (_tabController.index == 0) {
      _ordersBloc.add(GetOrdersEvent());
      setState(() {
        _ordersLoaded = false;
      });
    } else if (_tabController.index == 1) {
      _ordersBloc.add(GetOrdersScheduleEvent());
      setState(() {
        _schedulesLoaded = false;
      });
    }
  }

  void _showUpdateOrderStatusDialog(
      BuildContext context, delivery_models.Data order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<OrdersBloc, OrdersState>(
          listener: (context, state) {
            if (state is UpdateOrderStatueSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تم تحديث حالة الطلب بنجاح',
                    style: TextStyle(fontFamily: AppConstants.primaryFont),
                  ),
                ),
              );
              _ordersBloc.add(GetOrdersEvent());
            }
            if (state is OrdersError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: TextStyle(fontFamily: AppConstants.primaryFont),
                  ),
                ),
              );
            }
          },
          child: AlertDialog(
            title: Text(
              'تحديث حالة الطلب',
              style: TextStyle(
                fontFamily: AppConstants.primaryFont,
              ),
            ),
            content: Text(
              'هل تريد تحديث حالة هذا الطلب؟',
              style: TextStyle(
                fontFamily: AppConstants.primaryFont,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'إلغاء',
                  style: TextStyle(
                    fontFamily: AppConstants.primaryFont,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _ordersBloc
                      .add(UpdateOrderStatueEvent(id: order.purchaseOrderId!));
                  Navigator.of(context).pop();
                },
                child: Text(
                  'تأكيد',
                  style: TextStyle(
                    fontFamily: AppConstants.primaryFont,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onBackground;

    return BlocProvider.value(
      value: _ordersBloc,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: _buildAppBar(context, textColor),
        body: _buildBody(context, textColor),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Color textColor) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'الطلبات'),
          Tab(text: 'الجدول الزمني'),
        ],
        indicatorColor: Theme.of(context).primaryColor,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _handleRefresh,
          tooltip: 'تحديث',
        ),
      ],
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context, Color textColor) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildOrdersList(context, textColor),
        _buildSchedulesList(context, textColor),
      ],
    );
  }

  Widget _buildOrdersList(BuildContext context, Color textColor) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is GetOrdersSuccess) {
          _ordersLoaded = true;
        }
      },
      builder: (context, state) {
        if (state is OrdersLoading) {
          return _buildShimmerLoader();
        }
        if (state is GetOrdersSuccess) {
          return _buildOrdersListView(state.orders, textColor);
        }
        if (state is OrdersError) {
          return _buildErrorWidget(state.message, textColor);
        }
        // Initial state - load orders
        if (!_ordersLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _ordersBloc.add(GetOrdersEvent());
          });
        }
        return _buildShimmerLoader();
      },
    );
  }

  Widget _buildOrdersListView(
      delivery_models.DeliveryOrdersModel orders, Color textColor) {
    if (orders.data == null || orders.data!.isEmpty) {
      return Center(
        child: Text(
          'لا يوجد طلبات حالياً',
          style: TextStyle(
            color: textColor,
            fontFamily: AppConstants.primaryFont,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.sectionPadding),
      itemCount: orders.data!.length,
      itemBuilder: (context, index) {
        final order = orders.data![index];
        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.elementSpacing),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              child: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).primaryColor,
              ),
            ),
            title: Text(
              order.customerName ?? 'No Name',
              style: TextStyle(
                color: textColor,
                fontFamily: AppConstants.primaryFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.deliveryAddress ?? 'No Address',
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontFamily: AppConstants.primaryFont,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 14,
                      color: textColor.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      order.customerPhone ?? 'N/A',
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontFamily: AppConstants.primaryFont,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _showUpdateOrderStatusDialog(context, order),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSchedulesList(BuildContext context, Color textColor) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is GetOrdersScheduleSuccess) {
          _schedulesLoaded = true;
        }
      },
      builder: (context, state) {
        if (state is OrdersLoading) {
          return _buildShimmerLoader();
        }
        if (state is GetOrdersScheduleSuccess) {
          return _buildSchedulesListView(state.schedules, textColor);
        }
        if (state is OrdersError) {
          return _buildErrorWidget(state.message, textColor);
        }
        // Initial state - load schedules
        if (!_schedulesLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _ordersBloc.add(GetOrdersScheduleEvent());
          });
        }
        return _buildShimmerLoader();
      },
    );
  }

  Widget _buildSchedulesListView(
      schedule_models.OrdersScheduleModel schedules, Color textColor) {
    if (schedules.data == null || schedules.data!.isEmpty) {
      return Center(
        child: Text(
          'لا يوجد جدول زمني حالياً',
          style: TextStyle(
            color: textColor,
            fontFamily: AppConstants.primaryFont,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.sectionPadding),
      itemCount: schedules.data!.length,
      itemBuilder: (context, index) {
        final schedule = schedules.data![index];
        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.elementSpacing),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppConstants.cardRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              child: Icon(
                Icons.schedule,
                color: Theme.of(context).primaryColor,
              ),
            ),
            title: Text(
              'جدول ${schedule.id ?? "N/A"}',
              style: TextStyle(
                color: textColor,
                fontFamily: AppConstants.primaryFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: textColor.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      schedule.reciveDate ?? 'N/A',
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontFamily: AppConstants.primaryFont,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: textColor.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      schedule.deliveryTime ?? 'N/A',
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontFamily: AppConstants.primaryFont,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerLoader() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.sectionPadding),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: shimmerBaseColor,
          highlightColor: shimmerHighlightColor,
          child: Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: AppConstants.elementSpacing),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget(String message, Color textColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              color: textColor,
              fontFamily: AppConstants.primaryFont,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _handleRefresh,
            child: Text(
              'إعادة المحاولة',
              style: TextStyle(
                fontFamily: AppConstants.primaryFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _ordersBloc.close();
    super.dispose();
  }
}
