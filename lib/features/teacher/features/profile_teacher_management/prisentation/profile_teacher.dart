import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../util/colors.dart';
import '../../../../util/myTextField.dart';
import '../../../../util/show_message_on_screen.dart';
import '../data/profile_teacher_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';
import 'edit_profil_teacher.dart';

class ProfileTeacher extends StatefulWidget {

//proton vpn cli c -f -p tcp
  //late final String title;

  @override
  _ProfileTeacherState createState() => _ProfileTeacherState();
}


class _ProfileTeacherState extends State<ProfileTeacher>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 1, vsync: this);
  }

  double getHeight() {
    return 800;
  }
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }

  }
  ProfileTeacherModel? profileTeacherModel;
  @override
  Widget build(BuildContext context) {
    TextEditingController addPostController= TextEditingController();
    return BlocProvider(create: (BuildContext context)=>ProfileTeacherCubit()..getProfileInfo(),
    child: BlocConsumer<ProfileTeacherCubit,ProfileTeacherStatus>(
      listener: (context,state){
        if(state is ProfileTeacherSuccessState)
          profileTeacherModel=state.profileTeacherModel;
      if(state is DeletePostProfileTeacherSuccessState)
        {
          showMessageOnScreen(
              context: context,
              titleText: "Done",
              messageText: "deleted successfully ",
              backgroundColor: Colors.green,
              titleColor: Colors.white,
              messageColor: Colors.white);
          ProfileTeacherCubit.get(context).getProfileInfo();
        }
        if(state is AddPostProfileTeacherSuccessState)
        {
          showMessageOnScreen(
              context: context,
              titleText: "Done",
              messageText: "Add post  successfully ",
              backgroundColor: Colors.green,
              titleColor: Colors.white,
              messageColor: Colors.white);
            ProfileTeacherCubit.get(context).getProfileInfo();

        }
        },
      builder: (context,state){
        return Scaffold(
          //backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          body:profileTeacherModel?.data==null?Center(child: CircularProgressIndicator(),): SafeArea(
            child: Stack(
              children: [
                DefaultTabController(
                  length: 3,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                            floating: true,
                            pinned: true,
                            snap: true,
                            elevation: 0.4,
                            //elevation: 70,
                            collapsedHeight:60,
                            expandedHeight: 400.0,
                            backgroundColor: fillColorInTextFormField,
                            title: IconButton(icon: Icon(Icons.edit,color: Colors.pink,),onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfileTeacher(profileTeacherModel: profileTeacherModel,)));
                            },),
                            flexibleSpace: FlexibleSpaceBar(

                              // title: Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     SizedBox(height: 15.h),
                              //     Text('abd fayyad'),
                              //     SizedBox(height: 5.h),
                              //     Text('abd fayyad',style: TextStyle(fontSize: 14.sp),),
                              //   ],
                              // ),

                              background: Image(
                                image:AssetImage("assets/images/p.jpg"),
                                fit: BoxFit.fill,
                              ) ,
                            )
                          // Stack(
                          //   children: [
                          //     Image(
                          //
                          //       image: AssetImage('assets/images/login.png'),
                          //       fit: BoxFit.fill,
                          //     )
                          //   ],
                          // ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            minHeight: 160,
                            maxHeight: 160,
                            child: Container(
                                height: getHeight() * (1 / 11),
                                width: double.infinity,
                                color: fillColorInTextFormField,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text("${profileTeacherModel!.data!.name }  ",style: TextStyle(color: mainColor,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10.h,),
                                      Text("${profileTeacherModel!.data!.email } ",style: TextStyle(color: mainColor,fontSize: 18.sp,fontWeight: FontWeight.normal),) ,
                                      SizedBox(height: 10.h,),
                                      Divider(),
                                      Row(children:[ Text("phone number :",style: TextStyle(color: mainColor,fontSize: 20.sp,fontWeight: FontWeight.bold),)
                                            ,SizedBox(width: 10.h,)
                                       , Text("${profileTeacherModel!.data!.phoneNumber } ",style: TextStyle(color: mainColor,fontSize: 18.sp,fontWeight: FontWeight.normal),),

                                      ]),
                                      SizedBox(height: 10.h,),
                                      // SizedBox(height: 100,)

                                    ],

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                )
                            ),
                          ),
                        ),

                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            minHeight: 60,
                            maxHeight: 60,
                            child: Container(
                                height: getHeight() * (1 / 11),
                                width: double.infinity,
                                color: fillColorInTextFormField,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text("My posts",style: TextStyle(color: mainColor,fontSize: 20.sp,fontWeight: FontWeight.normal),),

                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                )
                            ),
                          ),
                        ),
                      ];
                    },
                    body:profileTeacherModel!.data!.posts==null?Center(child: CircularProgressIndicator(),):  ListView.builder(
                        itemCount: profileTeacherModel!.data!.posts!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CourseDetails()));
                                // navigateTo(context, CourseDetails());
                              },
                              child: Container(
                                  width: 100.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                      color: fillColorInTextFormField,
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: borderContainer,
                                      )),
                                  child: Column(

                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(child: Text("${profileTeacherModel!.data!.posts![index].post}",style: TextStyle(color: mainColor,fontSize: 20.sp,fontWeight: FontWeight.normal),)),
                                         IconButton(onPressed: (){
                                           ProfileTeacherCubit.get(context).deletePost(profileTeacherModel!.data!.posts![index].id!);

                                         }, icon: Icon(Icons.delete))
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   width: double.infinity,
                                      //   height:240,
                                      //   decoration: BoxDecoration(
                                      //     image: DecorationImage(
                                      //       image: NetworkImage('${profileTeacherModel!.data!.posts![index].image}'),
                                      //       fit: BoxFit.fill,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  )
                              ),
                            ),
                          );
                        }),
                  ),
                ),

              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (BuildContext ccontext) => Center(
                    child: Dialog(
                      backgroundColor: fillColorInTextFormField,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      //this right here
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200.h,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Add Title",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20.sp,
                                        color: mainColor)),
                                SizedBox(
                                  height: 5.h,
                                ),
                                myTextField(controller: addPostController),
                                SizedBox(
                                  height: 5.h,
                                ),
                                // Text("Add Your Photo",
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.normal,
                                //         fontSize: 20.sp,
                                //         color: mainColor)),
                                // SizedBox(
                                //   height: 5.h,
                                // ),
                                // InkWell(
                                //   onTap: () => _pickImage(ImageSource.gallery),
                                //   child: Container(
                                //     width: double.infinity,
                                //     height: 200,
                                //     color: Colors.grey,
                                //     child: _image != null
                                //         ? Image.file(File(_image!.path))
                                //         : Icon(Icons.add_photo_alternate, size: 50),
                                //   ),
                                // ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {Navigator.pop(context);},
                                        child: Text(
                                          'cancel',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 20.sp,
                                              color: mainColor),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    TextButton(
                                        onPressed: ()async {
                                          print(addPostController.text );
                                          ProfileTeacherCubit.get(context).addPost(addPostController.text );
                                          await Future.delayed(Duration(seconds: 1));
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 20.sp,
                                              color: mainColor),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.white,
          ),
        );
      },
    ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
class Showww extends StatefulWidget {
   Showww({Key? key,required this.widget}) : super(key: key);
Widget widget;
  @override
  State<Showww> createState() => _ShowwwState();
}

class _ShowwwState extends State<Showww> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: fillColorInTextFormField,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)),
        //this right here
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 400.h,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget,
            ),
          ),
        ),
      ),
    );
  }
}
