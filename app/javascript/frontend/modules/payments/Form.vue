<template>
  <form method="post" action="https://megakassa.ru/merchant/" accept-charset="UTF-8" target="_blank">
    <input type="hidden" name="shop_id" value="<%= ENV['MEGAKASSA_SHOP_ID'] %>" />
    <input type="hidden" name="amount" value="<%= price %>" />
    <input type="hidden" name="currency" value="RUB" />
    <input type="hidden" name="description" value="Telegabot <%= amount %> <%= name %>" />
    <input type="hidden" name="order_id" value="<%= order_id %>" />
    <input type="hidden" name="method_id" value="" />
    <input type="hidden" name="client_email" value="" />
    <input type="hidden" name="debug" value="" />
    <input type="hidden" name="signature" value="<%= generate_megakassa_signature( [ ENV['MEGAKASSA_SHOP_ID'], price, "RUB", "Telegabot #{amount} #{name}", order_id, '', '', '', ENV['MEGAKASSA_SIGNATURE'] ], true) %>" />
    <input type="hidden" name="language" value="ru" />
    <input type="submit" value="Купить", class="ui primary fluid button" />
  </form>
</template>
