import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/scan_qr_controller.dart';

import '../../utils/color_resources.dart';

class InfoAssetScreen extends StatefulWidget {
  final String code;

  const InfoAssetScreen({Key? key, required this.code}) : super(key: key);

  @override
  State<InfoAssetScreen> createState() => _InfoAssetScreenState();
}

class _InfoAssetScreenState extends State<InfoAssetScreen> {
  @override
  void initState() {
    Get.find<QrController>().getInfoAsset(widget.code);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 8, left: 8),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: ColorResources.getMainColor())),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: ColorResources.getMainColor(),
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          title: const Text('Thông tin tài sản',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<QrController>(
          builder: (controller) {
            return Container(margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  textInfo("Mã hệ thống: ${controller.assetInfo?.code ?? "-"}"),
                  textInfo("Tên tài sản: ${controller.assetInfo?.name ?? "-"}"),
                  textInfo(
                      "Mã quản lý: ${controller.assetInfo?.managementCode ?? "-"}"),
                  textInfo(
                      "Trạng thái: ${controller.assetInfo?.status.name ?? "-"}"),
                  textInfo(
                      "Nguyên giá: ${controller.assetInfo?.originalCost ?? "-"}"),
                  textInfo(
                      "Giá trị còn lại: ${controller.assetInfo?.unitPrice ?? "-"}"),
                  textInfo(
                      "Ngày tiếp nhận: ${controller.assetInfo?.dateOfReception ?? "-"}"),
                  textInfo(
                      "Đơn vị tính: ${controller.assetInfo?.unit.name ?? "-"}"),
                  textInfo("Model: ${controller.assetInfo?.serialNumber ?? "-"}"),
                  textInfo("Seri: ${controller.assetInfo?.name ?? "-"}"),
                  textInfo(
                      "Ngày hết hạn bảo hành: ${controller.assetInfo?.depreciationDate ?? "-"}"),
                  textInfo(
                      "Phòng quản lý: ${controller.assetInfo?.managementDepartment.name ?? "-"}"),
                  textInfo(
                      "Khoa/Phòng sử dụng: ${controller.assetInfo?.useDepartment.name ?? "-"}"),
                  textInfo(
                      "Người sử dụng: ${controller.assetInfo?.usePerson.displayName ?? "-"}"),
                  textInfo(
                      "Hình thức mua sắm: ${controller.assetInfo?.shoppingForm.name ?? "-"}"),
                  textInfo(
                      "Phân loại rủi ro: ${controller.assetInfo?.createdBy ?? "Loại A- Trang thiết bị có mức độ rủi do thấp"}"),
                  textInfo(
                      "Phân nhóm gói thầu: ${controller.assetInfo?.createdBy ?? "Nhóm 4"}"),
                  textInfo(
                      "Số lưu hành: ${controller.assetInfo?.circulationNumber ?? "-"}"),
                ],
              ),
            );
          },
        ));
  }

  Widget textInfo(String content) {
    return Container(margin: const EdgeInsets.only(top: 8), child: Text(content,style: TextStyle(fontSize: 14),));
  }
}
// 1. Mã hệ thống
// 2. Tên tài sản
// 3. Mã quản lý
// 4. Trạng thái
// 5. Nguyên giá
// 6. Giá trị còn lại
// 7. Ngày tiếp nhận
// 8. Năm sử dụng
// 9. Đơn vị tính
// 10. Model
// 11. Seri
// 12. Ngày hết hạn bảo hành
// 13. Phòng quản lý
// 14. Khoa/Phòng sử dụng
// 15. Người sử dụng
// 16. Hình thức mua sắm
// 17. Phân loại rủi ro
// 18. Phân nhóm gói thầu
// 19. Số lưu hành
