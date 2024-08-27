import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/model/my_user.dart';
import 'package:task_management/model/task.dart';

class FirebaseUtils {
  // Retrieves the tasks collection for a specific user
  static CollectionReference<Task> getTasksCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()!),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  // Adds a new task to Firestore
  static Future<void> addTaskToFireStorage(Task task, String uId) {
    var taskCollection = getTasksCollection(uId);
    DocumentReference<Task> taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  // Deletes a task from Firestore
  static Future<void> deleteTaskFromFirestore(Task task, String uId) {
    return getTasksCollection(uId).doc(task.id).delete();
  }

  // Updates an existing task in Firestore
  static Future<void> updateTaskInFirestore(Task task, String uId) {
    return getTasksCollection(uId).doc(task.id).update(task.toFireStore());
  }

  // Retrieves the users collection
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()),
          toFirestore: (myUser, options) => myUser.toFireStore(),
        );
  }

  // Adds a new user to Firestore
  static Future<void> addUserToFireStore(MyUser user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  // Reads a user from Firestore
  static Future<MyUser?> readUserFromFirestore(String userId) async {
    var querySnapshot = await getUsersCollection().doc(userId).get();
    return querySnapshot.data();
  }
}
