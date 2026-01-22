import 'package:flutter/material.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:study_path/core/utils/screen_util.dart';

class LinkPreviewer extends StatefulWidget {
  final String url;
  final double? imageWidth;
  final double? imageHeight;

  const LinkPreviewer({super.key, required this.url, this.imageWidth, this.imageHeight});

  @override
  State<LinkPreviewer> createState() => _LinkPreviewerState();
}

class _LinkPreviewerState extends State<LinkPreviewer> {
  // متغير عشان نحفظ فيه البيانات اللي راجعة
  Future<Metadata?>? _metadataFuture;

  @override
  void initState() {
    super.initState();
    // أول ما الويدجت يفتح بنبدأ نجيب البيانات
    _metadataFuture = _fetchMetadata();
  }

  // فنكشن بتجيب البيانات من الرابط
  Future<Metadata?> _fetchMetadata() async {
    try {
      // الكود ده بيعمل Scraping للتاجات الخاصة بالموقع
      var data = await MetadataFetch.extract(widget.url);
      return data;
    } catch (e) {
      // لو حصل أي ايرور في اللينك نرجع null
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Metadata?>(
      future: _metadataFuture,
      builder: (context, snapshot) {
        // 1. حالة التحميل
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. التحقق من وجود داتا وصورة
        final data = snapshot.data;
        final hasImage = data?.image != null && data!.image!.isNotEmpty;

        // التصميم الخارجي للكارد
        return Container(
          width:widget.imageWidth ?? double.infinity,
          height: widget.imageHeight ?? 250.h(context), // ارتفاع ثابت للصورة
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            // color: Colors.grey.shade100,
          ),
          clipBehavior: Clip.antiAlias, // عشان الصورة تاخد شكل الحواف
          child: hasImage
              ? Image.network(
            data!.image!,
            fit: BoxFit.cover,
            // لو الصورة موجودة بس اللينك بتاعها بايظ (Broken Link)
            errorBuilder: (context, error, stackTrace) {
              return _buildNoImageFallback();
            },
          )
              : _buildNoImageFallback(), // الحالة اللي طلبتها (لو مفيش صورة)
        );
      },
    );
  }

  // دي الويدجت اللي بتظهر لما ميكونش فيه صورة
  Widget _buildNoImageFallback() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
          SizedBox(height: 8),
          Text(
            "No image to preview",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}