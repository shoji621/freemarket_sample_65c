$(function(){
  Payjp.setPublicKey("pk_test_4550d06343c9b0f384b3edf9");
  $('#token_submit').on("click", function(e){ //IDがtoken_submitのボタンが押されたときに作動します
    e.preventDefault(); 

    //カード情報生成
    const card = {
      number: $("#card_number")[0].value,
      cvc: $("#cvc")[0].value,
      exp_month: $("#exp_month")[0].value,
      exp_year: $("#exp_year")[0].value
    }; //入力されたデータを取得します。

    //トークン生成
    Payjp.createToken(card, (status, response) => {
      if (status === 200) { //成功した場合
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name"); //カード情報を自分のサーバにpostせず削除します
        $("#card_token").append(
          $('<input type="hidden" name="payjp-token">').val(response.id)
        ); //トークンを送信できるように隠しタグを生成
        document.inputForm.submit();
        alert("登録が完了しました"); //確認用
      } else {
        alert("カード情報が正しくありません。"); //確認用
      }
    });
  });
});