import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesTile extends StatelessWidget {

  String imgUrl;
  String title;

  CategoriesTile({required this.title, required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Categorie(categorieName: title)));
      },
    
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        child: Stack(
          children: [
            GestureDetector(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(imgUrl: imgUrl,)));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                  child: Image.network(imgUrl, height: 50, width: 100,fit: BoxFit.cover,), ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black26,
                borderRadius: BorderRadius.circular(8)
              ),
              height: 50, width: 100,
              alignment: Alignment.center,
              child: Text(title, style: TextStyle(color: Colors.white, fontSize: 13),),
            )
          ],
        ),
      ),
    );
  }
}