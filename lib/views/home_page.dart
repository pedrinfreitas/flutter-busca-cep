import 'dart:convert';

import 'package:app_cep_turma/services/via_cep_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  String? _result;
  dynamic? responseData;

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar CEP'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSearchCepTextField(),
            _buildSearchCepButton(),
            _buildCleanCepButton(),
            _buildResultForm()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCepTextField() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(labelText: 'Cep'),
      controller: _searchCepController,
      enabled: _enableField,
    );
  }

  Widget _buildSearchCepButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ElevatedButton(
          onPressed: _searchCep,
          child: _loading ? _circularLoading() : const Text('Consultar'),
        ));
  }

  Widget _buildCleanCepButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ElevatedButton(
          onPressed: _clearButton,
          child: _loading ? _circularLoading() : const Text('Limpar'),
        ));
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: const CircularProgressIndicator(),
    );
  }

  Future _searchCep() async {
    _searching(true);

    final cep = _searchCepController.text;

    final resultCep = await ViaCepService.fetchCep(cep: cep);
    print(resultCep.localidade); // Exibindo somente a localidade no terminal

    setState(() {
      _result = resultCep.toJson();
      responseData = jsonDecode(resultCep.toJson());
    });

    _searching(false);
  }

  Future _clearButton() async {
    _searching(true);

    setState(() {
      _searchCepController.text = '';
      _result = '';
      responseData = null;
    });

    _searching(false);
  }

  Widget _buildResultForm() {
    String mensagem = "Digite o cep e clique em consultar";
    if (responseData != null) {
      return Column(children: [
        TextField(
          decoration: const InputDecoration(labelText: 'CEP'),
          controller: TextEditingController(text: responseData['cep']),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Logradouro'),
          controller: TextEditingController(text: responseData['logradouro']),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Complemento'),
          controller: TextEditingController(text: responseData['complemento']),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Bairro'),
          controller: TextEditingController(text: responseData['bairro']),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Localidade'),
          controller: TextEditingController(text: responseData['localidade']),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'UF'),
          controller: TextEditingController(text: responseData['uf']),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'IBGE'),
          controller: TextEditingController(text: responseData['ibge']),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'GIA'),
          controller: TextEditingController(text: responseData['gia']),
        ),
      ]);
    }
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(mensagem),
    );
  }

  // return Container(
  //     padding: const EdgeInsets.only(top: 20.0),
  //     child: Text(_result ?? ''),
}
