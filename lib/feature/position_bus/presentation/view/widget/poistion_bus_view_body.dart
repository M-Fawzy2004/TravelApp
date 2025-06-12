import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/list_view_governorate_card.dart';

class PoistionBusViewBody extends StatefulWidget {
  const PoistionBusViewBody({super.key, required this.governorateModel});

  final List<GovernorateModel> governorateModel;

  @override
  State<PoistionBusViewBody> createState() => _PoistionBusViewBodyState();
}

class _PoistionBusViewBodyState extends State<PoistionBusViewBody> {
  final TextEditingController _searchController = TextEditingController();
  List<MapEntry<String, List<Station>>> filteredGovernorates = [];
  List<MapEntry<String, List<Station>>> allGovernorates = [];

  @override
  void initState() {
    super.initState();
    allGovernorates = widget.governorateModel
        .expand((g) => g.data.entries.map((entry) => MapEntry(
              entry.value.namegovernorate,
              entry.value.stations,
            )))
        .toList();
    
    filteredGovernorates = List.from(allGovernorates);
  }

  void _filterGovernorates(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredGovernorates = List.from(allGovernorates);
      } else {
        filteredGovernorates = allGovernorates
            .where((governorate) => governorate.key
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightBox(10),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "مرحبًا بك في قسم المواقف",
            style: Styles.font16BlackBold(context).copyWith(
              color: AppColors.darkPrimaryColor,
            ),
          ),
        ),
        heightBox(10),
        Text(
          "هدفنا:\n- نخلّيك عارف السعر التقريبي قبل ما تركب.\n- نساعدك تختار أسرع وأنسب وسيلة.\n- ولو مش عارف تروح فين، هنقولك تركب إيه بالضبط.",
          style: Styles.font14GreyExtraBold(context),
        ),
        heightBox(10),
        Text(
          "أختر المحافظه ثم الموقف اللى هتركب منه : ",
          style: Styles.font16BlackBold(context).copyWith(
            color: AppColors.darkPrimaryColor,
          ),
        ),
        heightBox(10),
        CustomTextFormField(
          hintText: 'ادخل اسم المحافظة',
          controller: _searchController,
          onChanged: _filterGovernorates,
          prefixIcon: const Icon(Icons.search),
          showClearIcon: true,
        ),
        heightBox(10),
        if (filteredGovernorates.isEmpty && _searchController.text.isNotEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: AppColors.getPrimaryColor(context).withOpacity(0.5),
                  ),
                  heightBox(16),
                  Text(
                    'لا توجد محافظات تطابق البحث',
                    style: Styles.font16BlackBold(context),
                  ),
                ],
              ),
            ),
          )
        else
          ListViewGovernorateCard(
            governorates: filteredGovernorates,
          ),
        heightBox(80),
      ],
    );
  }
}