import 'package:flutter/material.dart';


class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<String> doctorsList = [null];
  static List<String> nursesList = [null];
  static List<String> staffsList = [null];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('Dynamic TextFormFields'),),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name textfield
                Text('Add Doctors', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                ..._getDoctors(),
                Text('Add Nurses', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                ..._getNurses(),
                Text('Add Staffs', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                ..._getStaffs(),
                SizedBox(height: 40,),
                FlatButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                    }
                  },
                  child: Text('Submit'),
                  color: Colors.green,
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }

  /// get firends text-fields
  List<Widget> _getDoctors(){
    List<Widget> doctorsTextFields = [];
    for(int i=0; i<doctorsList.length; i++){
      doctorsTextFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: DoctorsTextFields(i)),
                SizedBox(width: 16,),
                // we need add button at last friends row
                _addRemoveButtonD(i == doctorsList.length-1, i),
              ],
            ),
          )
      );
    }
    return doctorsTextFields;
  }
  List<Widget> _getNurses(){
    List<Widget> nursesTextFields = [];
    for(int i=0; i<nursesList.length; i++){
      nursesTextFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: NursesTextFields(i)),
                SizedBox(width: 16,),
                // we need add button at last friends row
                _addRemoveButtonN(i == nursesList.length-1, i),
              ],
            ),
          )
      );
    }
    return nursesTextFields;
  }
  List<Widget> _getStaffs(){
    List<Widget> staffsTextFields = [];
    for(int i=0; i<staffsList.length; i++){
      staffsTextFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: DoctorsTextFields(i)),
                SizedBox(width: 16,),
                // we need add button at last friends row
                _addRemoveButtonS(i == staffsList.length-1, i),
              ],
            ),
          )
      );
    }
    return staffsTextFields;
  }


  /// add / remove button
  Widget _addRemoveButtonD(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          doctorsList.insert(0, null);
        }
        else doctorsList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
      ),
    );
  }
  Widget _addRemoveButtonN(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          nursesList.insert(0, null);
        }
        else nursesList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
      ),
    );
  }
  Widget _addRemoveButtonS(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          staffsList.insert(0, null);
        }
        else staffsList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
      ),
    );
  }

}

class DoctorsTextFields extends StatefulWidget {
  final int index;
  DoctorsTextFields(this.index);
  @override
  _DoctorsTextFieldsState createState() => _DoctorsTextFieldsState();
}

class _DoctorsTextFieldsState extends State<DoctorsTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _MyFormState.doctorsList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _MyFormState.doctorsList[widget.index] = v,
      decoration: InputDecoration(
          hintText: 'Enter Doctor\'s name'
      ),
      validator: (v){
        if(v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

class NursesTextFields extends StatefulWidget {
  final int index;
  NursesTextFields(this.index);
  @override
  _NursesTextFieldsState createState() => _NursesTextFieldsState();
}

class _NursesTextFieldsState extends State<NursesTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _MyFormState.nursesList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _MyFormState.nursesList[widget.index] = v,
      decoration: InputDecoration(
          hintText: 'Enter Nurse\'s name'
      ),
      validator: (v){
        if(v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

class StaffsTextFields extends StatefulWidget {
  final int index;
  StaffsTextFields(this.index);
  @override
  _StaffsTextFieldsState createState() => _StaffsTextFieldsState();
}

class _StaffsTextFieldsState extends State<StaffsTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _MyFormState.staffsList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _MyFormState.staffsList[widget.index] = v,
      decoration: InputDecoration(
          hintText: 'Enter Staff\'s name'
      ),
      validator: (v){
        if(v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}



