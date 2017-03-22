# USER
user = Erp::User.first

# ARTICLES
puts "Create sample categories article"
Erp::Articles::Category.where(name: "Chính sách bảo hành").destroy_all
category1 = Erp::Articles::Category.create(name: "Chính sách bảo hành", alias: Erp::Articles::Category::ALIAS_WARRANTY, creator_id: user.id)
Erp::Articles::Category.where(name: "Quy định & Hình thức thanh toán").destroy_all
category2 = Erp::Articles::Category.create(name: "Quy định & Hình thức thanh toán", alias: Erp::Articles::Category::ALIAS_PAYMENT, creator_id: user.id)
Erp::Articles::Category.where(name: "Chính sách vận chuyển, giao nhận").destroy_all
category3 = Erp::Articles::Category.create(name: "Chính sách vận chuyển, giao nhận", alias: Erp::Articles::Category::ALIAS_DELIVERY, creator_id: user.id)
Erp::Articles::Category.where(name: "Chính sách đổi trả hàng và hoàn tiền").destroy_all
category4 = Erp::Articles::Category.create(name: "Chính sách đổi trả hàng và hoàn tiền", alias: Erp::Articles::Category::ALIAS_RETURN_REFUND, creator_id: user.id)
Erp::Articles::Category.where(name: "Quy định bảo mật thông tin").destroy_all
category5 = Erp::Articles::Category.create(name: "Quy định bảo mật thông tin", alias: Erp::Articles::Category::ALIAS_SECURITY, creator_id: user.id)
Erp::Articles::Category.where(name: "Các điều khoản & Điều kiện").destroy_all
category6 = Erp::Articles::Category.create(name: "Các điều khoản & Điều kiện", alias: Erp::Articles::Category::ALIAS_TERMS_CONDITIONS, creator_id: user.id)
Erp::Articles::Category.where(name: "Câu hỏi thường gặp").destroy_all
category7 = Erp::Articles::Category.create(name: "Câu hỏi thường gặp", alias: Erp::Articles::Category::ALIAS_FAQ, creator_id: user.id)

Erp::Articles::Category.where(name: "Khám phá").destroy_all
category8 = Erp::Articles::Category.create(name: "Khám phá", alias: Erp::Articles::Category::ALIAS_BLOG, creator_id: user.id)

puts "Create sample articles"
Erp::Articles::Article.where(name: "Chính sách bảo hành").destroy_all
article1 = Erp::Articles::Article.create(name: "Chính sách bảo hành", content: "Đang cập nhật...", category_id: category1.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Quy định & Hình thức thanh toán").destroy_all
article2 = Erp::Articles::Article.create(name: "Quy định & Hình thức thanh toán", content: "Đang cập nhật...", category_id: category2.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Chính sách vận chuyển, giao nhận").destroy_all
article3 = Erp::Articles::Article.create(name: "Chính sách vận chuyển, giao nhận", content: "Đang cập nhật...", category_id: category3.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Chính sách đổi trả hàng và hoàn tiền").destroy_all
article4 = Erp::Articles::Article.create(name: "Chính sách đổi trả hàng và hoàn tiền", content: "Đang cập nhật...", category_id: category4.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Quy định bảo mật thông tin").destroy_all
article5 = Erp::Articles::Article.create(name: "Quy định bảo mật thông tin", content: "Đang cập nhật...", category_id: category5.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Điều khoản thứ nhất").destroy_all
article6 = Erp::Articles::Article.create(name: "Điều khoản thứ nhất", content: "Đang cập nhật...", category_id: category6.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Điều khoản thứ hai").destroy_all
article6 = Erp::Articles::Article.create(name: "Điều khoản thứ hai", content: "Đang cập nhật...", category_id: category6.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Câu hỏi thứ nhất").destroy_all
article7 = Erp::Articles::Article.create(name: "Câu hỏi thứ nhất", content: "Đang cập nhật...", category_id: category7.id, creator_id: user.id)
Erp::Articles::Article.where(name: "Câu hỏi thứ hai").destroy_all
article7 = Erp::Articles::Article.create(name: "Câu hỏi thứ hai", content: "Đang cập nhật...", category_id: category7.id, creator_id: user.id)

Erp::Articles::Article.where(name: "Mark Zuckerberg đang thực hiện đúng chiến thuật của người La Mã cách đây 2.300 năm để hủy diệt các đối thủ").destroy_all
article8 = Erp::Articles::Article.create(
            name: "Mark Zuckerberg đang thực hiện đúng chiến thuật của người La Mã cách đây 2.300 năm để hủy diệt các đối thủ",
            content: "<p>C&acirc;u n&oacute;i &ldquo;Lịch sử tự lặp lại ch&iacute;nh n&oacute; &ndash; History repeats itself&rdquo; vẫn được nhắc đi nhắc lại mỗi lần ta n&oacute;i tới lịch sử. H&atilde;y nhắc lại ch&uacute;t &iacute;t về La M&atilde;, đế quốc h&ugrave;ng mạnh v&agrave; rộng lớn bậc nhất trong lịch sử.</p>\r\n<p>Trong chiến tranh với người Carthage, hay c&ograve;n được biết tới với c&aacute;i t&ecirc;n chiến tranh Punic, người La M&atilde; với gươm v&agrave; ngựa đ&atilde; thua tr&ecirc;n mặt nước &ndash; địa h&igrave;nh chiến đấu m&agrave; thủy qu&acirc;n của Carthage tỏ r&otilde; sức mạnh vượt trội.</p>",
            category_id: category8.id, creator_id: user.id)
Erp::Articles::Comment.where(message: "Nội dung bình luận đầu tiên")
comment1 = Erp::Articles::Comment.create(
            name: "Nguyễn Tôn Hùng",
            email: "hungnt@hoangkhang.com.vn",
            message: "Nội dung bình luận đầu tiên",
            article_id: article8.id,
            parent_id: ""
)