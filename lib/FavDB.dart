import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Favorite.dart';

class FavDB {
  var database;

  void create() async {
    database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'temp_database.db'),
      // When the database is first created, create a table to store favorites.
      onCreate: (db, version) {
        return db.execute(
          "Create TABLE IF NOT EXISTS favorites(id INTEGER PRIMARY KEY, "
              "lat REAL, lon REAL)"
        );
      },
      onUpgrade: (db, int oldVersion, int newVersion) {
        if (oldVersion < newVersion) {
          db.execute(
              "ALTER TABLE favorites ADD COLUMN personId INTEGER;");
        }
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 2,
    );
  }

  Future<void> insertFavorite(Favorite favorite) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the favorite into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same favorite is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'favorites',
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Favorite>> favorites() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Favorites.
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    // Convert the List<Map<String, dynamic> into a List<Favorite>.
    return List.generate(maps.length, (i) {
      return Favorite(
        id: maps[i]['id'],
        lat: maps[i]['lat'].toDouble(),
        lon: maps[i]['lon'].toDouble(),
        personId: maps[i]['personId'].toInt(),
      );
    });
  }



  Future<void> updateFavorite(Favorite favorite) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Favorite.
    await db.update(
      'favorites',
      favorite.toMap(),
      // Ensure that the Favorite has a matching id.
      where: "id = ?",
      // Pass the Favorite's id as a whereArg to prevent SQL injection.
      whereArgs: [favorite.id],
    );
  }

  Future<void> deleteFavorite(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Favorite from the database.
    await db.delete(
      'favorites',
      // Use a `where` clause to delete a specific favorite.
      where: "id = ?",
      // Pass the Favorite's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  void insert(Favorite favorite) async {
    await Future.delayed(Duration(milliseconds: 5), () => insertFavorite(favorite));
  }

  void update(Favorite favorite) async {
    await Future.delayed(Duration(milliseconds: 5), () =>updateFavorite(favorite));
  }

  void delete(int id) async {
    await Future.delayed(Duration(milliseconds: 5), () =>deleteFavorite(id));
  }
}