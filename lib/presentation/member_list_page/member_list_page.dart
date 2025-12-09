import 'package:rotary/presentation/member_list_page/widgets/member_item_widget.dart';
import 'package:rotary/widgets/app_bar/appbar_title_searchview.dart';
import 'package:rotary/widgets/app_bar/custom_app_bar.dart';
import 'bloc/member_list_bloc.dart';
import 'models/member_list_model.dart';
import 'models/member_item_model.dart';
import 'package:rotary/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class MemberPage extends StatefulWidget {
  const MemberPage({Key? key})
      : super(
          key: key,
        );

  @override
  MemberListPageState createState() => MemberListPageState();
  static Widget builder(BuildContext context) {
    return BlocProvider<MemberListBloc>(
      create: (context) => MemberListBloc(MemberListState(
        memberListModelObj: MemberListModel(),
      ))
        ..add(MemberListInitialEvent()),
      child: MemberPage(),
    );
  }
}

class MemberListPageState extends State<MemberPage>
    with AutomaticKeepAliveClientMixin<MemberPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildMemberList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 70.h,
      title: BlocSelector<MemberListBloc, MemberListState, TextEditingController?>(
          selector: (state) => state.searchController,
          builder: (context, searchController) {
            return AppbarTitleSearchview(
              margin: EdgeInsets.all(15.h),
              controller: searchController,
              suffix: Padding(
                padding: EdgeInsets.only(
                  right: 2.h,
                ),
                child: IconButton(
                  onPressed: () {
                    searchController!.clear();
                    context.read<MemberListBloc>().add(MemberListInitialEvent());
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              onTapSearchButton: (value) {
                print(value);
                context
                    .read<MemberListBloc>()
                    .add(SearchKeywordMemberEvent(value));
              },
            );
          }),
    );
  }

  /// Section Widget
  Widget _buildMemberList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10.h),
      child: BlocSelector<MemberListBloc, MemberListState, MemberListModel?>(
        selector: (state) => state.memberListModelObj,
        builder: (context, memberListModelObj) {
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 10.v,
              );
            },
            itemCount: memberListModelObj?.memberlistItemList.length ?? 0,
            itemBuilder: (context, index) {
              MemberItemModel model = memberListModelObj?.memberlistItemList[index] ?? MemberItemModel();
              return MemberListPageStateListItemWidget(model);
            },
          );
        },
      ),
    );
  }

  onTapSearchItems(BuildContext context) {}
}
