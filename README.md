# 🛡️ Bash Backup Script with Automatic Rotation

This is a simple Bash script that creates timestamped backups of a given folder using `rsync`. It also handles **backup rotation**, automatically deleting the oldest backups to keep only the most recent ones.

---

## 📦 Features

- 🔁 Backup rotation with maximum count control
- 🕒 Timestamped backups with unique numeric IDs
- 📄 Individual log file for each backup run
- 🚫 Prevents recursive backups by excluding previous backups
- ✅ Simple and fast with no dependencies beyond Bash and rsync

---

## 🧰 Requirements

- Bash (pre-installed on most systems)
- `rsync` utility

---

## 🚀 Usage

```bash
./backup.sh /path/to/your/folder
```

Replace `/path/to/your/folder` with the folder you want to back up.

---

## ⚙️ Configuration

Edit the script to change the following values:

```bash
MAX_BACKUPS=3
```

This controls how many backups to keep. The oldest one will be deleted automatically when the count exceeds this limit.

---

## 🧠 How It Works

1. **Accepts a folder path** as the first argument.
2. Reads a file named `backup_ids.log` in the folder to track the last backup ID.
3. Increments the ID and creates a new backup folder:
   ```
   backup_YYYY-MM-DD_HH-MM-SS_<ID>
   ```
4. Uses `rsync` to copy the folder's contents, **excluding** any previous backup folders.
5. If the number of backups exceeds `MAX_BACKUPS`, the script deletes the oldest backup using the ID stored in the log.
6. A `.log` file is also created for each backup.

---

## 📂 Backup Folder Structure

Each time the script runs, it creates:

- A backup directory:
  ```
  /your/folder/backup_2025-05-09_14-00-00_3
  ```

- A log file:
  ```
  /your/folder/backup_2025-05-09_14-00-00.log
  ```

- A backup ID is recorded in:
  ```
  /your/folder/backup_ids.log
  ```

---

## ⚠️ Notes

- ⚠️ **Never back up into the same folder without excluding previous backups**, or you'll cause infinite recursion.
- 🧽 This script uses the pattern `backup_*` to exclude old backups — adjust this if your naming scheme changes.
- 🛠️ This is intended for **lightweight, local use**. For mission-critical backups, use professional tools like:
  - [`rsnapshot`](https://rsnapshot.org/)
  - [`borg`](https://www.borgbackup.org/)
  - [`restic`](https://restic.net/)

---

## ⏰ Automating with Cron

To run the script daily at midnight, add this to your crontab (`crontab -e`):

```cron
0 0 * * * /full/path/to/backup.sh /path/to/folder
```

---

## 🔐 Recommendations

- 📁 Store backups **outside** the original folder if possible, like:
  ```
  ./backup.sh /home/user/data /mnt/external/backups/data
  ```
- 🔒 Secure your backups with proper permissions.
- 🧹 Consider adding a cleanup routine if logs grow too large.

---

## 📜 License

MIT License — free for personal and commercial use.

---

## ✨ Example Output

```bash
Backup created: /home/omar/projects/backup_2025-05-09_14-00-00_5
Removing oldest backup with ID: 2
```

---

Made with 🤍 by Omar.
