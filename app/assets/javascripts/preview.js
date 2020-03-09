$(function(){
  $(document).off('click').on('click', '.upload_image', function(){
  })
  $(document).first().off('change').on('change', '.upload_image', function(){
    console.log($('input[type="file"]'))
    let files 
    if($(".imageBox").length < 5){
      files = $('.upload_image').first().prop('files')[0]
      
    }else{
      // 本来6番目だが、1~5のflexBoxにiconのfa-cameraが詰まっているため7番目となる
      files = $(`#item_images_attributes_${$(".imageBox").length}_image`).prop('files')[0]
      console.log($(`#item_images_attributes_${$(".imageBox").length}_image`))
    }
    let fileReader = new FileReader();
    fileReader.onloadend = function(){
      let src = fileReader.result
      let html = 
      `
      <div class="imageBox" id="${$(".imageBox").length}">
        <div>
          <img src=${src} width="120px" height="140px">
        </div>
        <div class="bottomBtn">

          <div class="item_image_deleteBtn">削除</div>
        </div>
      </div>
      `
      if($(".imageBox").length >= 5){
        $("#item_image_six_to_ten").before(html)
      }else{
        $("#item_image_one_to_five").before(html)
      }
    }
    fileReader.readAsDataURL(files)
    $(".image_text").remove()
    if($(".imageBox").length == 4){
      $("#item_image_one_to_five").css('display', 'none')
      html = 
      `
      <div class="flexBox" id='flexBox_six_to_ten'>
        <label class="product_default_image" id="item_image_six_to_ten" for="item_image">
          <i class="fas fa-camera"></i>
          <div class="image_text">クリックしてファイルをアップロード</div>
        </label>
      </div>
      `
      $(".flexBox").after(html)
    }
    else if($(".imageBox").length == 9){
      $("#item_image_six_to_ten").css('display', 'none')
    }

    // ここから画像機能編集
    image_number = $(".imageBox").length + 1
    html = 
    `
    <input accept="image/jpg,image/jpeg,image/png,image/gif" class="upload_image" type="file" name="item[images_attributes][${image_number}][image]" id="item_images_attributes_${image_number}_image">
    `
    $(".product_default_image").last().prepend(html)
    $(".product_default_image").last().removeAttr("for")
    $(".product_default_image").last().attr("for", `item_images_attributes_${image_number}_image`)
  })
  $(document).off('click').on('click', ".item_image_deleteBtn", function(){
    let delete_object = $(this).parent().parent()
    let n = delete_object.attr("id")
    n = parseInt(n, 10)
    delete_object.remove()
    let num = $(".imageBox").length
    $(document).find(`#item_images_attributes_${n}_image`).remove()
    $(document).find(`#item_images_attributes_${num + 1}_image`).remove()

    // 繰り返し処理
    $.each($(document).find(".upload_image"), function(){
      text = $(this).attr("id")
      text = text.replace(/[^0-9]/g, "");
      number = parseInt(text, 10)
      
      if(number > n){
        $(this).removeAttr("id")
        $(this).removeAttr("name")
        $(this).attr("id", `item_images_attributes_${number - 1}_image`)
        $(this).attr("name", `item[images_attributes][${number - 1}][image]`)
      }
    })
    $.each($(document).find(".imageBox"), function(){
      id_n = $(this).attr("id")
      id_n = parseInt(id_n)
      if(id_n > n){
        $(this).removeAttr("id")
        $(this).attr("id", id_n - 1)
      }
    })
    

    let image_number = $(".imageBox").length
    html = 
    `
    <input accept="image/jpg,image/jpeg,image/png,image/gif" class="upload_image" type="file" name="item[images_attributes][${num}][image]" id="item_images_attributes_${image_number}_image">
    `
    if(num <= 4){
      $(".product_default_image").first().append(html)
      $(".product_default_image").first().removeAttr("for")
      $(".product_default_image").first().attr("for", `item_images_attributes_${num}_image`)
    }else{
      $(".product_default_image").last().append(html)
      $(".product_default_image").last().removeAttr("for")  
      $(".product_default_image").last().attr("for", `item_images_attributes_${num}_image`)
    }
    // 上段を削除したときの処理
    if(num >= 5){
      if($("#flexBox_one_to_five").children(".imageBox").length == 4){
        // 上段を削除した際に下段の初めから要素をとってきて移動させる
        $("#flexBox_six_to_ten").children(".imageBox:first").insertBefore($('#flexBox_one_to_five').children('#item_image_one_to_five'))
        $("#item_images_attributes_4_image").insertBefore($("#item_images_attributes_3_image"))
      }
    }
    // imageBoxが残っていないとき
    if(num == 0){
      let html =
      `
      <div class="image_text">クリックしてファイルをアップロード</div>
      `
      $(".upload_image").after(html)
    }
    else if(num == 9){
      $('#item_image_six_to_ten').css('display', 'block')
    }
    else if(num == 5){
      let html =
      `
      <div class="image_text">クリックしてファイルをアップロード</div>
      `
      // ここのクラスを変える必要がある(6-10にいれる)
      $("#upload_image_six_to_ten").after(html)
    }
    else if(num == 4){
      $('#flexBox_six_to_ten').remove()
      $('#item_image_one_to_five').css('display', 'block')
      
    }
  })
  $(".priceBox").off("keyup").on("keyup", function(){
    if($(this).val() >= 300 && $(this).val() <= 9999999){
      $('.price_text').remove()
      a_html =
      `
      <div class="price_text">
        ¥${$(this).val()*0.1}
      </div>
      `
      p_html =
      `
      <div class="price_text">
        ¥${$(this).val()*0.9}
      </div>
      `
      $(".tax_Box").children(".topBox").after(a_html)
      $("#profit_Box").children(".topBox").after(p_html)
    }else{
      $('.price_text').remove()
      html =
      `
      <div class="price_text">
        ー
      </div>
      `
      $(".tax_Box").children(".topBox").after(html)
      $("#profit_Box").children(".topBox").after(html)
    }
  })
})
