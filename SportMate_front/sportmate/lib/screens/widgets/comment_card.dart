
import 'package:flutter/material.dart';
import 'package:sportmate/logic/comment.dart';
import 'package:sportmate/logic/mail.dart';
import 'package:sportmate/screens/widgets/inherited_services.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _isHidden = false;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if(_isHidden){
          return const SizedBox.shrink();
        }else{
          return Card(
            margin: const EdgeInsets.all(4),
            color: const Color(0xFF2F2D2D),
            child: FutureBuilder(
              future: Mail.readMail(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  if(snapshot.data == widget.comment.eMail){
                    return ListTile(
                      leading: IconButton(
                          onPressed: () {
                            InheritedServices.of(context).services.apis.commentApi.deleteComment(widget.comment.idComm!);
                            setState(() {
                              _isHidden = true;
                            });
                          },
                          icon: Icon(Icons.close, color: InheritedServices.of(context).services.couleurs.textColor)
                      ),
                      title: Text(
                          "${widget.comment.firstName} ${widget.comment.lastName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: InheritedServices.of(context).services.couleurs.textColor
                          )
                      ),
                      subtitle: Text(
                          widget.comment.commentContent!,
                          style: TextStyle(
                              color: InheritedServices.of(context).services.couleurs.textColor
                          )
                      ),
                    );
                  }else{
                    return ListTile(
                      title: Text(
                          "${widget.comment.firstName} ${widget.comment.lastName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: InheritedServices.of(context).services.couleurs.textColor
                          )
                      ),
                      subtitle: Text(
                          widget.comment.commentContent!,
                          style: TextStyle(
                              color: InheritedServices.of(context).services.couleurs.textColor
                          )
                      ),
                    );
                  }
                }else{
                  return ListTile(
                    title: Text(
                        "${widget.comment.firstName} ${widget.comment.lastName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: InheritedServices.of(context).services.couleurs.textColor
                        )
                    ),
                    subtitle: Text(
                        widget.comment.commentContent!,
                        style: TextStyle(
                            color: InheritedServices.of(context).services.couleurs.textColor
                        )
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}
