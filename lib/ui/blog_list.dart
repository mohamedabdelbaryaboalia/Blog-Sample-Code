import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeward_interview_sample_code/business_logic/models/blog.dart';
import 'package:homeward_interview_sample_code/business_logic/providers/blog_provider.dart';
import 'package:homeward_interview_sample_code/business_logic/providers/login_provider.dart';
import 'package:homeward_interview_sample_code/services/utils/constants.dart';
import 'package:homeward_interview_sample_code/services/utils/custom_page_route.dart';
import 'package:homeward_interview_sample_code/ui/blog_entry.dart';
import 'package:provider/provider.dart';

import 'custom_widgets/mh_toast.dart';
import 'login.dart';

class BlogList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BlogListState();
}

class BlogListState extends State<BlogList> {
  late final Future<List<Blog>> _getBlogList;

  @override
  void initState() {
    super.initState();
    _getBlogList =
        Provider.of<BlogProvider>(context, listen: false).getBlogList();
  }

  @override
  Widget build(BuildContext context) {
    final BlogProvider _blogProvider =
        Provider.of<BlogProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Constants.themeAccent,
        title: Text("Demo App"),
        leading: InkWell(
          onTap: () {
            showConfirmationDialog(
                "Sign out",
                "Are you sure you want to Sign out ?",
                "Yes",
                "No",
                context, () async {
              await Provider.of<LoginProvider>(context, listen: false)
                  .signOut();
              Toast.show("Logged Out Successfully", context,
                  duration: Toast.lengthLong);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            });
          },
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.userTimes,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Blog>>(
        future: _getBlogList,
        builder: (__, AsyncSnapshot<List<Blog>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              itemCount: snapshot.data?.length,
              staggeredTileBuilder: (int index) {
                return StaggeredTile.count(2, index.isEven ? 2 : 3);
              },
              itemBuilder: (BuildContext context, int index) {
                final Blog blogItem = snapshot.data![index];
                return Hero(
                  tag: "Blog Item No ${blogItem.id}",
                  child: Card(
                    color: Colors.white,
                    child: InkWell(
                        onTap: () {
                          if (blogItem.id != null) {
                            Navigator.push(
                                context,
                                CustomPageRoute(
                                    previousPage: context
                                        .dependOnInheritedWidgetOfExactType(),
                                    builder: (context) =>
                                        BlogEntry(blogItem.id!)));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    blogItem.title ?? "",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                        color: Colors.grey.shade800,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                              Expanded(
                                  child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(blogItem.image ?? "")),
                                  )))
                                ],
                              )),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    _blogProvider.formatter.format(
                                        DateTime.parse(
                                            blogItem.createTime ?? "")),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                        color: Constants.themeAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ))
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  // * -------------------------- Alert Dialogs ------------------------------ //
  void showConfirmationDialog(
      String title,
      String description,
      String btnOkText,
      String btnCancelTxt,
      BuildContext context,
      Function() callback) {
    AwesomeDialog(
      context: context,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: description,
      btnOkText: btnOkText,
      btnCancelText: btnCancelTxt,
      btnOkOnPress: callback,
      btnCancelOnPress: () {},
    ).show();
  }
}
