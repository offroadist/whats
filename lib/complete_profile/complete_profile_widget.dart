import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteProfileWidget extends StatefulWidget {
  const CompleteProfileWidget({Key? key}) : super(key: key);

  @override
  _CompleteProfileWidgetState createState() => _CompleteProfileWidgetState();
}

class _CompleteProfileWidgetState extends State<CompleteProfileWidget> {
  String uploadedFileUrl = '';
  TextEditingController? imageURLController;
  TextEditingController? displayNameController;
  TextEditingController? yourTitleController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    displayNameController = TextEditingController();
    imageURLController = TextEditingController();
    yourTitleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Complete Profile',
          style: FlutterFlowTheme.of(context).title2,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: InkWell(
                onTap: () async {
                  final selectedMedia = await selectMedia(
                    maxWidth: 1000.00,
                    maxHeight: 1000.00,
                    mediaSource: MediaSource.photoGallery,
                    multiImage: false,
                  );
                  if (selectedMedia != null &&
                      selectedMedia.every(
                          (m) => validateFileFormat(m.storagePath, context))) {
                    showUploadMessage(
                      context,
                      'Uploading file...',
                      showLoading: true,
                    );
                    final downloadUrls = (await Future.wait(selectedMedia.map(
                            (m) async =>
                                await uploadData(m.storagePath, m.bytes))))
                        .where((u) => u != null)
                        .map((u) => u!)
                        .toList();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    if (downloadUrls.length == selectedMedia.length) {
                      setState(() => uploadedFileUrl = downloadUrls.first);
                      showUploadMessage(
                        context,
                        'Success!',
                      );
                    } else {
                      showUploadMessage(
                        context,
                        'Failed to upload media',
                      );
                      return;
                    }
                  }
                },
                child: Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    valueOrDefault<String>(
                      imageURLController!.text,
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/dark-mode-chat-xk2sj6/assets/ails754ngloi/uiAvatar@2x.png',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: TextFormField(
              controller: imageURLController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Image URL',
                labelStyle: FlutterFlowTheme.of(context).bodyText1,
                hintText: 'Copy an avatar here...',
                hintStyle: FlutterFlowTheme.of(context).bodyText1,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              style: FlutterFlowTheme.of(context).subtitle2,
              keyboardType: TextInputType.url,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: TextFormField(
              controller: displayNameController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Your Name',
                labelStyle: FlutterFlowTheme.of(context).bodyText1,
                hintText: 'What name do you go by?',
                hintStyle: FlutterFlowTheme.of(context).bodyText1,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              style: FlutterFlowTheme.of(context).subtitle2,
              keyboardType: TextInputType.name,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: TextFormField(
              controller: yourTitleController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Your Title',
                labelStyle: FlutterFlowTheme.of(context).bodyText1,
                hintText: 'What do you do?',
                hintStyle: FlutterFlowTheme.of(context).bodyText1,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              style: FlutterFlowTheme.of(context).subtitle2,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                final usersUpdateData = createUsersRecordData(
                  photoUrl: valueOrDefault<String>(
                    imageURLController!.text,
                    'https://image.flaticon.com/icons/png/512/3135/3135715.png',
                  ),
                  displayName: displayNameController!.text,
                  userRole: yourTitleController!.text,
                  createdTime: getCurrentTimestamp,
                );
                await currentUserReference!.update(usersUpdateData);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavBarPage(initialPage: 'chatMain'),
                  ),
                );
              },
              text: 'Save Profile',
              options: FFButtonOptions(
                width: 230,
                height: 60,
                color: FlutterFlowTheme.of(context).primaryText,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                elevation: 3,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
