class Message {
  final int id; // معرف الرسالة
  final int employeeId; // معرف الموظف
  final String? content; // نص الرسالة
  final String? fileName; // اسم الملف
  final String? fileUrl; // رابط الملف
  final String? readStatus; // حالة القراءة
  final DateTime? readAt; // تاريخ القراءة
  final String? archiveStatus; // حالة الأرشفة
  final String createdBy; // مُرسل الرسالة
  final String createdAt; // تاريخ الإرسال

  Message({
    required this.id,
    required this.employeeId,
    this.content,
    this.fileName,
    required this.fileUrl,
    this.readStatus,
    this.readAt,
    this.archiveStatus,
    required this.createdBy,
    required this.createdAt,
  });
}
