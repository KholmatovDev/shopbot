import 'dart:async';
import 'dart:ffi';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class Bot {
  var inlineKeyboard = InlineKeyboardMarkup(inlineKeyboard: [
    [
      InlineKeyboardButton(text: "#kinoya ^", url: "https://t.me/kinoyac"),
    ],
  ]);
  var replyKeyboard = ReplyKeyboardMarkup(keyboard: [
    [KeyboardButton(text: "Tekshirish ✅")],
  ]);
  final selectOsButtons = ReplyKeyboardMarkup(
    resizeKeyboard: true,
    keyboard: [
      [
        KeyboardButton(text: "Windows 💻"),
        KeyboardButton(text: "Android 📱"),
      ],
    ],
  );
  final windowsSelCategory = ReplyKeyboardMarkup(
    resizeKeyboard: true,
    keyboard: [
      [
        KeyboardButton(text: "Messenjerlar ✉️"),
        KeyboardButton(text: "Brauzerlar 🕸"),
      ],
      [
        KeyboardButton(text: "Utilitalar 🧱"),
        KeyboardButton(text: "O'yinlar 🎮"),
      ],
    ],
  );
  final windowsBrowsers = ReplyKeyboardMarkup(
    keyboard: [
      [
        KeyboardButton(text: "Chrome Browser"),
        KeyboardButton(text: "FireFox Browser"),
      ],
      [
        KeyboardButton(text: "Tor Browser"),
        KeyboardButton(text: "Opera Browser"),
      ],
      [
        KeyboardButton(text: "Yandex Browser"),
        KeyboardButton(text: "Vivaldi Browser"),
      ],
      [
        KeyboardButton(text: "Bosh Sahifaga 🏠"),

      ],
    ],
  );

  void run(bool start) async {
    var token = '8121047504:AAFUBwxi-7ziix9mE30TnQ8FIazBZpwb9Bk';
    final username = (await Telegram(token).getMe()).username;
    var teledart = TeleDart(token, Event(username!));

    teledart.start();
    start ? null : teledart.stop();

    teledart.onCommand().listen(
      (message) {
        if (message.text!.contains("/start")) {
          message.reply(
              "Salom 👋\n\n🤖 Ushbu bot orqali - 💻 Kompyuter va 📱 Android uchun o'yin va dasturlarni yuklab olishingiz "
              "mumkin.\n\n⁉️ Savol va takliflar uchun:\n ✉️ kholmatov.dev@gmail.com yoki\n 👤 @ukinoya - ga murojat qilishingiz "
              "mumkin"
              ". \n\n🪳 Bug Report: @xr_coder\n\n↘️ Kuzatib boring:\n 📹 www.YouTube.com/@XRCoder\n 🍵 https://t.me/xrcoder, "
              "https://t.me/kinoyac",
              replyMarkup: selectOsButtons);

          print("object2222");
        }

        Timer(Duration(seconds: 1), () async {
          if (!(await checkSubscription(teledart: teledart, userId: message.chat.id))) {
            teledart.sendMessage(
              message.chat.id,
              "Botdan foydalanish uchun obuna bo'ling",
              replyMarkup: inlineKeyboard,
            );
            Timer(
              const Duration(milliseconds: 500),
              () => message.reply("Tekshirish", replyMarkup: replyKeyboard),
            );
          }
        });
      },
    );
    teledart.onMessage().listen((message) async {
      if (message.text == ("Tekshirish ✅")) {
        if (await checkSubscription(teledart: teledart, userId: message.chat.id)) {
          message.reply("${message.chat.firstName} Xush kelibsiz!!!", replyMarkup: selectOsButtons);
        } else {
          message.reply("Obuna bo'lmagansiz. Botdan foydalanish uchun iltimos obuna bo'ling.", replyMarkup: inlineKeyboard);
        }
      }
      if(message.text =="Bosh Sahifaga 🏠"){
        message.reply("Operatsion tizimni tanlang:", replyMarkup: selectOsButtons);
      }
      if (message.text == "Windows 💻") {
        message.reply("Windows dasturlari:", replyMarkup: windowsSelCategory);
      }
      if (message.text == "Brauzerlar 🕸") {
        message.reply("Windows uchun brauserlar:", replyMarkup:windowsBrowsers);
      }
      if(message.text == "Chrome Browser"){
        teledart.sendDocument(message.chat.id, "https://t.me/kinoyaApps/3");
      }
    });
  }

  Future<bool> checkSubscription({required TeleDart teledart, required int userId}) async {
    final chatMember = await teledart.getChatMember(-1002345434602, userId);
    if (chatMember.status == 'member') {
      print(chatMember.status);

      return true;
    } else {
      return false;
    }
  }
}
