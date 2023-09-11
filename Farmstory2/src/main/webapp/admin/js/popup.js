/**
 * 
 */
    $(function(){

        $('.showPopup').click(function(e){
            e.preventDefault();
            
            const tr = $(this).parent().parent();
            const orderNo = tr.find('.orderNo').text();
            const thumb = tr.find('.thumb1').text();
            const receiver = tr.find('.receiver').text();
            const address  = tr.find('.address').text();
            const pName = tr.find('.pName').text();
            const price = tr.find('.price').text();
            const count = tr.find('.count').text();
            const delivery = tr.find('.delivery').text();
            const total = tr.find('.total').text();
            const orderer = tr.find('.orderer').text();
            const date = tr.find('.orderDate').text();
            
            const popup = $('#orderPopup');
            popup.find('.orderNo').text(orderNo);
            popup.find('.thumb > img').attr('src', '/Farmstory2/thumb/'+thumb);
            popup.find('.receiver').text(receiver);
            popup.find('.address').text(address);
            popup.find('.pName').text(pName);
            popup.find('.price').text(price);
            popup.find('.count').text(count);
            popup.find('.delivery').text(delivery);
            popup.find('.total').text(total);
            popup.find('.orderer').text(orderer);
            popup.find('.date').text(date);
            popup.show();
        	
        });

        $('#orderPopup .btnClose').click(function(){
            $('#orderPopup').hide();
        });

    });