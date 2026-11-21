# চলো কথা বলি — Android starter

এটি Flutter-এ তৈরি একটি **প্রাথমিক UI ডেমো**। এতে লগইন স্ক্রিন, চ্যাট লিস্ট, ডেমো চ্যাট, কল/গ্রুপ/প্রোফাইল ট্যাব আছে।

## গুরুত্বপূর্ণ সীমাবদ্ধতা
- মোবাইল নম্বরের স্ক্রিনটি এখন শুধু ডেমো প্রবেশ করায়; এটি আসল SMS OTP পাঠায় না।
- মেসেজগুলো শুধু অ্যাপ চলাকালীন ডিভাইসের মেমরিতে থাকে। অন্য ব্যবহারকারীর কাছে যায় না।
- আসল public chat চালু করতে Firebase Authentication (Phone OTP), Cloud Firestore, Storage, নিরাপত্তা Rules, abuse reporting/blocking এবং privacy policy যোগ করতে হবে।
- কল/ভিডিও কল UI-র placeholder; বাস্তব কলের জন্য আলাদা calling service দরকার।

## APK তৈরি
এই প্রজেক্টে GitHub Actions workflow আছে:
1. GitHub-এ নতুন repository তৈরি করুন।
2. এই ZIP-এর ফাইলগুলো repository-তে upload করুন।
3. Actions ট্যাবে গিয়ে `Build Android APK` workflow চালান (অথবা push-এর পর স্বয়ংক্রিয়ভাবে চলবে)।
4. workflow শেষ হলে Artifacts থেকে `cholo-kotha-boli-debug-apk` ডাউনলোড করুন।
5. ZIP খুলে APK Android ফোনে install করুন। ফোনে browser/file manager থেকে install অনুমতি চাইতে পারে।

লোকাল build-এর জন্য Flutter SDK লাগবে:
`flutter pub get`
`flutter build apk --debug`

## পরের ধাপ: আসল অনলাইন চ্যাট
Firebase project তৈরি করে Android app register করতে হবে, Phone sign-in enable করতে হবে, Firestore ও Storage configure করতে হবে। তারপর Firebase config যুক্ত করে OTP ও real-time message code বসাতে হবে। Production release-এর আগে security rules, privacy policy, age-appropriate moderation, reporting/blocking এবং testing জরুরি.
