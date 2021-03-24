import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeward_interview_sample_code/business_logic/models/blog.dart';
import 'package:homeward_interview_sample_code/business_logic/providers/blog_provider.dart';
import 'package:homeward_interview_sample_code/services/utils/constants.dart';
import 'package:provider/provider.dart';

class BlogEntry extends StatefulWidget {
  final int id;
  const BlogEntry(this.id);
  @override
  State<StatefulWidget> createState() => BlogEntryState();
}

class BlogEntryState extends State<BlogEntry> {
  late final Future<Blog?> _getBlogItem;
  @override
  void initState() {
    super.initState();
    _getBlogItem = Provider.of<BlogProvider>(context, listen: false)
        .getBlogItemDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final BlogProvider _blogProvider =
        Provider.of<BlogProvider>(context, listen: false);
    return FutureBuilder<Blog?>(
        future: _getBlogItem,
        builder: (__, AsyncSnapshot<Blog?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  backgroundColor: Constants.themeAccent,
                  title: Text(snapshot.data?.title ?? ""),
                  leading: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.arrowAltCircleLeft,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                body: Hero(
                  tag: "Blog Item No ${widget.id}",
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                snapshot.data?.title ?? "",
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
                                    image: NetworkImage(
                                        snapshot.data?.image ?? "")),
                              )))
                            ],
                          )),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                _blogProvider.formatter.format(DateTime.parse(
                                    snapshot.data?.createTime ?? "")),
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
                    ),
                  ),
                ));
          }
          return Scaffold(
              backgroundColor: Colors.grey.shade200,
              appBar: AppBar(
                backgroundColor: Constants.themeAccent,
                title: Text(snapshot.data?.title ?? ""),
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.arrowAltCircleLeft,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              body: Container());
        });
  }
}
