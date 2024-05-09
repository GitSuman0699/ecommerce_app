import 'package:firebase_project/data/model/checkout_model.dart';
import 'package:firebase_project/screens/checkout/checkout_controller.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/device/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PaymentOptionWidget extends ConsumerStatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<PaymentMethod>? paymentMethod;

  const PaymentOptionWidget({
    Key? key,
    required this.paymentMethod,
    required this.formKey,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentOptionWidgetState();
}

class _PaymentOptionWidgetState extends ConsumerState<PaymentOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilder(
                key: widget.formKey,
                child: FormBuilderRadioGroup(
                  activeColor: AppColors.primary,
                  orientation: OptionsOrientation.vertical,
                  decoration: const InputDecoration(
                      border: InputBorder.none, fillColor: Colors.white),
                  initialValue: "",
                  onChanged: (value) {
                    ref
                        .read(paymentTypeProvider.notifier)
                        .update((state) => value!);

                    print(ref.read(paymentTypeProvider));
                  },
                  // disabled: paymentDisableList,
                  name: 'value',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Please select any one payment method')
                  ]),
                  options: widget.paymentMethod!
                      .map((lang) => FormBuilderFieldOption(
                            value: lang.value,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lang.title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                // fontWeight: FontWeight.bold,
                                                // color: lang.disabled!
                                                //     ? AppColors.primaryGreyText
                                                //     : AppColors.black,
                                                // decoration: lang.disabled!
                                                //     ? TextDecoration.lineThrough
                                                //     : null,
                                                ),
                                      ),
                                      // Text(
                                      //   lang.description!,
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodyMedium!
                                      //       .copyWith(fontSize: 11.sp),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(growable: true),
                  controlAffinity: ControlAffinity.leading,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
