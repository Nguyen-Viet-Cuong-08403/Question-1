-- Trong năm 2017 hãy cho biết mỗi product_group có bao nhiêu đơn hàng thành công và tỉ lệ mỗi nhóm là bao nhiêu so với tổng đơn hàng

with Table_1 as (
select p.product_group as Nhóm_Sản_Phẩm, count(order_id) as Số_Đơn_Hàng_Thành_Công
from payment_history_17 as pay17
join product as p
on pay17.product_id= p.product_number
join table_message as mess
on pay17.message_id=mess.message_id
where [description] ='success'
group by p.product_group
), Table_2 as (
select p.product_group as Nhóm_Sản_Phẩm , count(cast(pay17.order_id as Bigint)) as Tổng_Đơn_Hàng
from payment_history_17 as pay17
join product as p
on pay17.product_id= p.product_number
join table_message as mess
on pay17.message_id=mess.message_id
group by p.product_group
)
Select Table_1.* , Tổng_Đơn_Hàng, (cast(Số_Đơn_Hàng_Thành_Công as Decimal(10,2))/Tổng_Đơn_Hàng)*100 as Tỉ_Lệ_Giao_Hàng
from Table_1
join Table_2
on Table_1.Nhóm_Sản_Phẩm=Table_2.Nhóm_Sản_Phẩm