import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/constants/app_constants.dart';
import 'package:start/features/availableTimes/Bloc/bloc/available_times_bloc.dart';
import 'package:start/features/availableTimes/Models/AvailableTimesModel.dart';
import 'package:start/features/availableTimes/Models/addAvailble.dart';

class AvailableTimesScreen extends StatefulWidget {
  static const String routeName = '/available-times';

  const AvailableTimesScreen({super.key});

  @override
  State<AvailableTimesScreen> createState() => _AvailableTimesScreenState();
}

class _AvailableTimesScreenState extends State<AvailableTimesScreen> {
  late AvailableTimesBloc _availableTimesBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _timesLoaded = false;

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
    _availableTimesBloc = AvailableTimesBloc(client: NetworkApiServiceHttp());
  }

  void _handleRefresh() {
    _availableTimesBloc.add(AvailableTimesEvent());
    setState(() {
      _timesLoaded = false;
    });
  }

  // Helper function to show time picker and return in H:i format
  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Format time to H:i format (24-hour)
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      controller.text = '$hour:$minute';
    }
  }

  // Helper function to normalize day of week values
  String _normalizeDayOfWeek(String day) {
    // Convert to lowercase and capitalize first letter to match dropdown items
    if (day.isEmpty) return day;
    return day[0].toUpperCase() + day.substring(1).toLowerCase();
  }

  void _showAddTimeDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _startTimeController = TextEditingController();
    final _endTimeController = TextEditingController();

    // Days of week options - use consistent case
    final List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    String? selectedDay;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<AvailableTimesBloc, AvailableTimesState>(
          listener: (context, state) {
            if (state is AddAvailableSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تمت إضافة الوقت بنجاح',
                    style: TextStyle(fontFamily: AppConstants.primaryFont),
                  ),
                ),
              );
              _availableTimesBloc.add(AvailableTimesEvent());
            }
            if (state is AvailableTimesError) {
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
                      'إضافة وقت متاح جديد',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppConstants.primaryFont,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Day of week dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'يوم الأسبوع',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppConstants.cardRadius),
                        ),
                      ),
                      items: daysOfWeek.map((String day) {
                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedDay = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى اختيار يوم الأسبوع';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Start time field with time picker
                    TextFormField(
                      controller: _startTimeController,
                      decoration: InputDecoration(
                        labelText: 'وقت البدء (HH:mm)',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppConstants.cardRadius),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () =>
                              _selectTime(context, _startTimeController),
                        ),
                      ),
                      readOnly: true,
                      onTap: () => _selectTime(context, _startTimeController),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال وقت البدء';
                        }
                        // Validate HH:mm format
                        final regex =
                            RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
                        if (!regex.hasMatch(value)) {
                          return 'يرجى إدخال الوقت بصيغة صحيحة (HH:mm)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // End time field with time picker
                    TextFormField(
                      controller: _endTimeController,
                      decoration: InputDecoration(
                        labelText: 'وقت الانتهاء (HH:mm)',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppConstants.cardRadius),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () =>
                              _selectTime(context, _endTimeController),
                        ),
                      ),
                      readOnly: true,
                      onTap: () => _selectTime(context, _endTimeController),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال وقت الانتهاء';
                        }
                        // Validate HH:mm format
                        final regex =
                            RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
                        if (!regex.hasMatch(value)) {
                          return 'يرجى إدخال الوقت بصيغة صحيحة (HH:mm)';
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
                            if (_formKey.currentState!.validate() &&
                                selectedDay != null) {
                              final availability = Availabilities(
                                dayOfWeek: selectedDay!,
                                startTime: _startTimeController.text,
                                endTime: _endTimeController.text,
                              );

                              final addAvailable = AddAvilable(
                                availabilities: [availability],
                              );

                              _availableTimesBloc.add(AddAvailableEvent(
                                avilable: addAvailable,
                              ));
                            } else if (selectedDay == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'يرجى اختيار يوم الأسبوع',
                                    style: TextStyle(
                                        fontFamily: AppConstants.primaryFont),
                                  ),
                                ),
                              );
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

  void _showEditTimeDialog(BuildContext context, Data time) {
    final _formKey = GlobalKey<FormState>();
    final _startTimeController = TextEditingController(text: time.startTime);
    final _endTimeController = TextEditingController(text: time.endTime);

    // Days of week options - use consistent case
    final List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    // Normalize the day of week to match dropdown items
    String? selectedDay =
        time.dayOfWeek != null ? _normalizeDayOfWeek(time.dayOfWeek!) : null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocListener<AvailableTimesBloc, AvailableTimesState>(
          listener: (context, state) {
            if (state is AddAvailableSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تم تعديل الوقت بنجاح',
                    style: TextStyle(fontFamily: AppConstants.primaryFont),
                  ),
                ),
              );
              _availableTimesBloc.add(AvailableTimesEvent());
            }
            if (state is AvailableTimesError) {
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
                      'تعديل الوقت',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppConstants.primaryFont,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Day of week dropdown
                    DropdownButtonFormField<String>(
                      value: selectedDay,
                      decoration: InputDecoration(
                        labelText: 'يوم الأسبوع',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppConstants.cardRadius),
                        ),
                      ),
                      items: daysOfWeek.map((String day) {
                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedDay = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى اختيار يوم الأسبوع';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Start time field with time picker
                    TextFormField(
                      controller: _startTimeController,
                      decoration: InputDecoration(
                        labelText: 'وقت البدء (HH:mm)',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppConstants.cardRadius),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () =>
                              _selectTime(context, _startTimeController),
                        ),
                      ),
                      readOnly: true,
                      onTap: () => _selectTime(context, _startTimeController),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال وقت البدء';
                        }
                        // Validate HH:mm format
                        final regex =
                            RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
                        if (!regex.hasMatch(value)) {
                          return 'يرجى إدخال الوقت بصيغة صحيحة (HH:mm)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // End time field with time picker
                    TextFormField(
                      controller: _endTimeController,
                      decoration: InputDecoration(
                        labelText: 'وقت الانتهاء (HH:mm)',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppConstants.cardRadius),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () =>
                              _selectTime(context, _endTimeController),
                        ),
                      ),
                      readOnly: true,
                      onTap: () => _selectTime(context, _endTimeController),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال وقت الانتهاء';
                        }
                        // Validate HH:mm format
                        final regex =
                            RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
                        if (!regex.hasMatch(value)) {
                          return 'يرجى إدخال الوقت بصيغة صحيحة (HH:mm)';
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
                            if (_formKey.currentState!.validate() &&
                                selectedDay != null) {
                              final availability = Availabilities(
                                dayOfWeek: selectedDay!,
                                startTime: _startTimeController.text,
                                endTime: _endTimeController.text,
                              );

                              final updateAvailable = AddAvilable(
                                availabilities: [availability],
                              );

                              _availableTimesBloc.add(UpdateAvailableEvent(
                                avilable: updateAvailable,
                              ));
                            } else if (selectedDay == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'يرجى اختيار يوم الأسبوع',
                                    style: TextStyle(
                                        fontFamily: AppConstants.primaryFont),
                                  ),
                                ),
                              );
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
      value: _availableTimesBloc,
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
          onPressed: () => _showAddTimeDialog(context),
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
        'الأوقات المتاحة',
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
    return BlocConsumer<AvailableTimesBloc, AvailableTimesState>(
      listener: (context, state) {
        if (state is GetAvailbleTimesSuccess) {
          _timesLoaded = true;
        }
      },
      builder: (context, state) {
        if (state is AvailableTimesLoading) {
          return _buildShimmerLoader();
        }
        if (state is GetAvailbleTimesSuccess) {
          return _buildTimesListView(state.times, textColor);
        }
        if (state is AvailableTimesError) {
          return _buildErrorWidget(state.message, textColor);
        }
        // Initial state - load times
        if (!_timesLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _availableTimesBloc.add(AvailableTimesEvent());
          });
        }
        return _buildShimmerLoader();
      },
    );
  }

  Widget _buildTimesListView(AavailableTimesModel times, Color textColor) {
    if (times.data == null || times.data!.isEmpty) {
      return Center(
        child: Text(
          'لا يوجد أوقات متاحة حالياً',
          style: TextStyle(
            color: textColor,
            fontFamily: AppConstants.primaryFont,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.sectionPadding),
      itemCount: times.data!.length,
      itemBuilder: (context, index) {
        final time = times.data![index];
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
                Icons.access_time,
                color: Theme.of(context).primaryColor,
              ),
            ),
            title: Text(
              time.dayOfWeek != null
                  ? _normalizeDayOfWeek(time.dayOfWeek!)
                  : 'No Day',
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
                      Icons.play_arrow,
                      size: 14,
                      color: textColor.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time.startTime ?? 'N/A',
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontFamily: AppConstants.primaryFont,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.stop,
                      size: 14,
                      color: textColor.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time.endTime ?? 'N/A',
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
                  onPressed: () => _showEditTimeDialog(context, time),
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
    _availableTimesBloc.close();
    super.dispose();
  }
}
