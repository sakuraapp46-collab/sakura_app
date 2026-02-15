import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../onboarding/domain/onboarding_model.dart';

class OnboardingProvider extends InheritedNotifier<OnboardingModel>
{
  const OnboardingProvider({
    required OnboardingModel model,
    required super.child,
    super.key,
  }) : super(notifier: model);

  static OnboardingModel of(BuildContext context)
  {
    final provider = context.dependOnInheritedWidgetOfExactType<OnboardingProvider>();
    assert(provider != null, 'No OnboardingProvider found in context');
    return provider!.notifier!;
  }
}
