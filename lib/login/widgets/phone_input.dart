import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneInput extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  const PhoneInput({super.key, required this.formKey});

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: FormBuilderTextField(
        style: FontStyles.montserratRegular14(),
        name: 'mobile',
        decoration: InputDecoration(
          labelText: '10-digit mobile number',
          labelStyle: FontStyles.montserratRegular14(),
          prefixText: "+91 ",
          prefixStyle: FontStyles.montserratRegular14(),
          prefixIcon: const Icon(
            Icons.phone_android_outlined,
            color: AppColors.primary,
          ),
        ),
        onChanged: (code) {
          if (code!.length == 10) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: 'Mobile number is requied'),
          FormBuilderValidators.numeric(),
          FormBuilderValidators.maxLength(10,
              errorText: 'Mobile number should be of 10 digit'),
          FormBuilderValidators.minLength(10,
              errorText: 'Mobile number should be of 10 digit'),
        ]),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
