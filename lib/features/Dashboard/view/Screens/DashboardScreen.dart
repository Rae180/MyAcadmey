import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/constants/app_constants.dart';
import 'package:start/features/Dashboard/Bloc/bloc/places_bloc.dart';
import 'package:start/features/Dashboard/Models/PlacesModel.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PlacesBloc _placesBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _placesLoaded = false;

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
    _placesBloc = PlacesBloc(client: NetworkApiServiceHttp());
  }

  void _handleRefresh() {
    _placesBloc.add(GetPlacesEvent());
    setState(() {
      _placesLoaded = false;
    });
  }

  void _showAddPlaceDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _placeNameController = TextEditingController();
    final _priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<PlacesBloc, PlacesState>(
          listener: (context, state) {
            if (state is AddNewPlaceSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تمت إضافة المكان بنجاح',
                    style: TextStyle(fontFamily: AppConstants.primaryFont),
                  ),
                ),
              );
              _placesBloc.add(GetPlacesEvent());
            }
            if (state is PlacesError) {
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
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'إضافة مكان جديد',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppConstants.primaryFont,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _placeNameController,
                      decoration: InputDecoration(
                        labelText: 'اسم المكان',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppConstants.cardRadius),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال اسم المكان';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'السعر',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppConstants.cardRadius),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال السعر';
                        }
                        if (int.tryParse(value) == null) {
                          return 'يرجى إدخال رقم صحيح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'إلغاء',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontFamily: AppConstants.primaryFont,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _placesBloc.add(AddNewPlaceEvent(
                                placeName: _placeNameController.text,
                                price: _priceController.text,
                              ));
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            'حفظ',
                            style:
                                TextStyle(fontFamily: AppConstants.primaryFont),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditPlaceDialog(BuildContext context, Places place) {
    final _formKey = GlobalKey<FormState>();
    final _priceController =
        TextEditingController(text: place.price.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<PlacesBloc, PlacesState>(
          listener: (context, state) {
            if (state is UpdatePlaceSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تم تعديل السعر بنجاح',
                    style: TextStyle(fontFamily: AppConstants.primaryFont),
                  ),
                ),
              );
              _placesBloc.add(GetPlacesEvent());
            }
            if (state is PlacesError) {
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
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'تعديل سعر المكان',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppConstants.primaryFont,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      place.place ?? 'No Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppConstants.primaryFont,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'السعر الجديد',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppConstants.cardRadius),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال السعر';
                        }
                        if (int.tryParse(value) == null) {
                          return 'يرجى إدخال رقم صحيح';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'إلغاء',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontFamily: AppConstants.primaryFont,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _placesBloc.add(UpdatePlaceEvent(
                                place: place.place!,
                                price: _priceController.text,
                              ));
                            }
                          },
                          child: Text(
                            'حفظ',
                            style:
                                TextStyle(fontFamily: AppConstants.primaryFont),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
      value: _placesBloc,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: _buildAppBar(context, textColor),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            _handleRefresh();
          },
          child: _buildBody(context, textColor),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddPlaceDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Color textColor) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Text(
        'الأماكن',
        style: TextStyle(
          color: textColor,
          fontFamily: AppConstants.primaryFont,
          fontWeight: FontWeight.bold,
        ),
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
    return BlocConsumer<PlacesBloc, PlacesState>(
      listener: (context, state) {
        if (state is GetPlacesSuccess) {
          _placesLoaded = true;
        }
      },
      builder: (context, state) {
        if (state is PlacesLoading) {
          return _buildShimmerLoader();
        }
        if (state is GetPlacesSuccess) {
          return _buildPlacesListView(state.places, textColor);
        }
        if (state is PlacesError) {
          return _buildErrorWidget(state.message, textColor);
        }
        // Initial state - load places
        if (!_placesLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _placesBloc.add(GetPlacesEvent());
          });
        }
        return _buildShimmerLoader();
      },
    );
  }

  Widget _buildPlacesListView(PlacesModel places, Color textColor) {
    if (places.places == null || places.places!.isEmpty) {
      return Center(
        child: Text(
          'لا يوجد أماكن حالياً',
          style: TextStyle(
            color: textColor,
            fontFamily: AppConstants.primaryFont,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.sectionPadding),
      itemCount: places.places!.length,
      itemBuilder: (context, index) {
        final place = places.places![index];
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
                Icons.place,
                color: Theme.of(context).primaryColor,
              ),
            ),
            title: Text(
              place.place ?? 'No Name',
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
                      Icons.attach_money,
                      size: 14,
                      color: textColor.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${place.price ?? 'N/A'}',
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
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _showEditPlaceDialog(context, place),
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
            height: 80,
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
    _placesBloc.close();
    super.dispose();
  }
}
