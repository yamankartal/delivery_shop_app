String convertIntoDeliveryStatus(int deliveryStatus){

  if(deliveryStatus==-1){
    return "offline";
  }

    return "online";

}

String convertIntoPaymentMethode(int paymentMethode){

  if(paymentMethode==0){
    return "Cache";
  }

  return "Electronic";

}