import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  TextEditingController _controllerSuchbegriff = TextEditingController();
  ValueChanged<String>? callback;

  SearchWidget({required this.callback});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    callback!(value);
                  },
                  controller: _controllerSuchbegriff,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusColor: Colors.black12,
                    hoverColor: Colors.black12,
                    fillColor: Colors.black12,
                    labelText: 'Suche',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    //border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _controllerSuchbegriff.clear();
                callback!("");
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              icon: Icon(Icons.clear),
            ),
          ],
        ),
      ),
    );
  }
}
