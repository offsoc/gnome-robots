/* find-file.vala:

   Copyright 2006 Callum McKenzie

   This library is free software; you can redistribute it and'or modify
   it under the terms of the GNU Library General Public License as published
   by the Free Software Foundation; either version 3, or (at your option)
   any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Library General Public License for more details.

   You should have received a copy of the GNU Library General Public License
   along with this library; if not, see <http://www.gnu.org/licenses/>.

   Authors:   Callum McKenzie <callum@spooky-possum.org>
*/

string make_canonical_name (string name) {
    /* Strip the path. */
    var cname = Path.get_basename (name);
    /* Strip the suffix. */
    var s = cname.last_index_of_char ('.');
    if (s >= 0)
        cname = cname.substring (0, s);

    /* Remove case-sensitivity. */
    cname = cname.casefold ();
    /* Normalise the UTF-8 encoding. */
    cname = cname.normalize (-1, NormalizeMode.ALL);

    return cname;
}

int compare_names (string filename, string ctarget) {
    var cname = make_canonical_name (filename);
    return cname.collate (ctarget);
}

public string games_find_similar_file (string target, string directory) {
    var ctarget = make_canonical_name (target);
    var list = new GamesFileList ("*", directory);
    return list.find (compare_names, ctarget);
}
