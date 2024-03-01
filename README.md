## Что это такое? 
#### Кратко: прилага, позволяющая заменить в номере код +375 на **80 и потом отправить список набранных номеров в телеграм
#### Не кратко: 
Pet-проект, который на самом деле приносил мне пользу. Работая в техподдержке, мне необходимо было пользоваться call-центром. Это значит, что в моём телефоне есть вторая sim-карта, на которую приходят звонки от пользователей. А иногда пользователя нужно набрать и мне, но со старым центром была особенность - чтобы набрать номер клиента и он на вызове увидел именно общий номер call-центра (а не конкретно этой симки), нужно перед вызовом изменить номер на формат **80(AA)XXX-YY-ZZ. На Xiaomi всё просто - там приложение телефон позволяет изменить номер перед вызовом. Приложение Телефон на iOS такой роскоши не предоставляет. Нужно копировть номер в какое-нибудь текстовое поле, менять его, затем вставлять обратно в телефон и вызывать. Поэтому я сделал свой вариант на swift. 
### Что умеет приложение:
- подхватывать текст из буфера обмена сразу вставляя его в поле ввода номера
- убирать ненужное +375 и замещать его на **80
- набирать изменённый номер (не нужно возвращаться в телефон и вставлять его для набора)
- хранить список номеров, которые были конвертированы (до перезапуска прилаги)
- отправлять список в группу в телеграмме через бота
  
![gifka](https://github.com/smalldevcloud/SupCaller/assets/80459916/f9201de7-9272-48a3-bf7a-57574a061eb3)
