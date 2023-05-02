import 'dart:math';

import 'package:flutter/material.dart';

class rate extends StatelessWidget{
  const rate({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child:Column(
            children: [
              FlutterLogo(
                size:100,
              ),
              Text(
                'College Management System',
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,),
              ),
              Spacer(),
              TextButton.icon(
                onPressed: (){
                  openRatingDialog(context);
                },
                style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.1),
                  ),
                ),
                icon:Icon(Icons.star),
                label:Text(
                  'Rate us!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openRatingDialog(BuildContext context){
    showDialog(context: context,
      builder:(context){
        return Dialog(
          child: RatingView(),
        );
      },
    );
  }
}

class RatingView extends StatefulWidget{
  const RatingView({Key?key}): super(key:key);

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView>{
  var _ratingPageController = PageController();
  var _starPosition= 200.0;
  var _rating=0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Stack(
        children: [
          Container(
            height: max(300,MediaQuery.of(context).size.height*0.3),
            child: PageView(
              controller: _ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                //_causeOfRating(),
              ],
            ),
          ),
          Positioned(
            bottom:0,
            left:0,
            right:0,
            child: Container(
              color:Colors.red,
              child:MaterialButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child:Text('Done'),
                textColor: Colors.white,
              ),
            ),
          ),
          Positioned(
            right:0,
            child:MaterialButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child:Text('Skip'),
            ),
          ),
          AnimatedPositioned(
            top: _starPosition,
            left:0,
            right:0,
            child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:List.generate(5, (index) => IconButton(
                  icon: index < _rating ?
                  Icon(Icons.star,size:32):
                  Icon(Icons.star_border,size:32),
                  color:Colors.red,
                  onPressed: (){
                    setState(() {
                      _starPosition=40.0;
                      _rating=index+1;
                    });
                  },
                ))
            ),
            duration: Duration(microseconds: 300),
          ),
        ],
      ),
    );
  }

  _buildThanksNote(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Thanks for using the app',
          style:TextStyle(
            fontSize: 24,
            color:Colors.red,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text('We would like to get your rating'),
        Text('How was your experience?'),
      ],
    );
  }
}
