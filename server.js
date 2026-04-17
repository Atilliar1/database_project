const express = require('express');
const mysql = require('mysql2/promise');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

const pool = mysql.createPool({
  host: 'localhost',
  user: '',
  password: '',
  database: 'MartialArtsSchoolDB',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

function pageTemplate(title, body) {
  return `<!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${title}</title>
    <style>
      :root {
        --bg: #ffffff;
        --panel: #ffffff;
        --panel-2: #fef2f2;
        --accent: #dc2626;
        --accent-2: #b91c1c;
        --text: Black;
        --muted: #6b7280;
        --danger: #dc2626;
        --success: #16a34a;
        --border: #9C9898;
      }
      * { box-sizing: border-box; }
      body {
        margin: 0;
        font-family: Arial, Helvetica, sans-serif;

        background: 
          linear-gradient(rgba(255,255,255,0.85), rgba(255,255,255,0.85)),
          url('/karate.png') no-repeat center center;

        background-size: cover;
        background-attachment: fixed;
      }   
      nav {
        background: #dc2626;
        border-bottom: 1px solid var(--border);
        position: sticky;
        top: 0;
        z-index: 10;
      }
      .nav-inner {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        gap: 14px;
        flex-wrap: nowrap;
        padding: 14px 20px;
        align-items: center;
        overflow-x: auto;
      }
      .brand {
    font-weight: 700;
    margin-right: 10px;
    white-space: nowrap;  /* 🔥 THIS FIXES IT */
  }
      nav a {
        color: white;
        text-decoration: none;
        padding: 8px 12px;
        border-radius: 10px;
        white-space: nowrap;   /* ✅ keeps text on one line */
      }
      nav a:hover { background: rgba(255, 255, 255, 0.18); color: white; }
      .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 24px 20px 40px;
      }
      h1, h2, h3 { margin-top: 0; }
      .grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 18px;
      }
        .welcome-card {
          text-align: center;
        }

        .welcome-card .actions {
          display: flex;
          justify-content: center;
          gap: 10px;
          flex-wrap: wrap;
        }
      .card {
        background: var(--panel);
        border: 1px solid var(--border);
        border-radius: 18px;
        padding: 18px;
        box-shadow: 0 10px 25px rgba(220, 38, 38, 0.12);
      }
      .stat {
        font-size: 2rem;
        font-weight: 700;
        margin-top: 8px;
        color: var(--accent);
      }
      .muted { color: var(--muted); }
      form {
        display: grid;
        gap: 12px;
      }
      .form-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
        gap: 12px;
      }
      input, select {
        width: 100%;
        padding: 10px 12px;
        border-radius: 10px;
        border: 1px solid var(--border);
        background: white;
        color: var(--text);
      }
      button {
        cursor: pointer;
        padding: 10px 14px;
        border-radius: 10px;
        border: none;
        background: var(--accent);
        color: white;
        font-weight: 700;
      }
      button:hover { background: var(--accent-2); }
      .danger { background: var(--danger); }
      .danger:hover { filter: brightness(0.95); }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 12px;
        background: #ffffff;
        border-radius: 18px;
        overflow: hidden;
        table-layout: fixed;
      }

      th, td {
        border-bottom: 1px solid var(--border);
        padding: 12px;
        text-align: left;
        vertical-align: top;
      }

      th {
        background: #dc2626;
        color: white;
      }

      td {
        background: #ffffff;
        color: #111827;
      }
      .inline { display: inline; }
      .section-gap { margin-top: 24px; }
      .banner {
        padding: 12px 14px;
        border-radius: 12px;
        margin-bottom: 16px;
        border: 1px solid var(--border);
      }
      .ok { background: rgba(22, 163, 74, 0.18); }
      .link-btn {
        display: inline-block;
        text-decoration: none;
        background: var(--accent);
        color: white;
        padding: 10px 14px;
        border-radius: 10px;
      }
      .link-btn:hover { background: var(--accent-2); color: white; }
    </style>
  </head>
  <body>
    <nav>
      <div class="nav-inner">
        <div class="brand">Martial Arts School DB</div>
        <a href="/">Dashboard</a>
        <a href="/students">Students</a>
        <a href="/instructors">Instructors</a>
        <a href="/martial-arts">Classes</a>
        <a href="/ranks">Ranks</a>
        <a href="/enrollments">Enrollments</a>
        <a href="/teaches">Assignments</a>
        <a href="/reports">Reports</a>
        <a href="/views">Views</a>
      </div>
    </nav>
    <div class="container">
      ${body}
    </div>
  </body>
  </html>`;
}

function escapeHtml(value) {
  return String(value ?? '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;');
}

function alertBox(req) {
  if (!req.query.msg) return '';
  return `<div class="banner ok">${escapeHtml(req.query.msg)}</div>`;
}

function renderTable(headers, rows) {
  const head = headers.map(h => `<th>${escapeHtml(h)}</th>`).join('');
  const body = rows.map(row => `<tr>${row.map(cell => `<td>${cell}</td>`).join('')}</tr>`).join('');
  return `<table><thead><tr>${head}</tr></thead><tbody>${body}</tbody></table>`;
}

function redirectWithMessage(res, path, msg) {
  res.redirect(`${path}?msg=${encodeURIComponent(msg)}`);
}

app.get('/', async (req, res) => {
  const [[studentCount], [instructorCount], [classCount], [enrollmentCount], [rankCount]] = await Promise.all([
    pool.query('SELECT COUNT(*) AS count FROM Students'),
    pool.query('SELECT COUNT(*) AS count FROM Instructors'),
    pool.query('SELECT COUNT(*) AS count FROM MartialArts'),
    pool.query('SELECT COUNT(*) AS count FROM Enrolled'),
    pool.query('SELECT COUNT(*) AS count FROM Ranks'),
  ]);

  const body = `
    <h1>Dashboard</h1>
    ${alertBox(req)}
    <div class="grid">
      <div class="card"><div class="muted">Students</div><div class="stat">${studentCount[0].count}</div></div>
      <div class="card"><div class="muted">Instructors</div><div class="stat">${instructorCount[0].count}</div></div>
      <div class="card"><div class="muted">Classes</div><div class="stat">${classCount[0].count}</div></div>
      <div class="card"><div class="muted">Enrollments</div><div class="stat">${enrollmentCount[0].count}</div></div>
      <div class="card"><div class="muted">Ranks</div><div class="stat">${rankCount[0].count}</div></div>
    </div>
    <div class="card section-gap welcome-card">
      <h2>Welcome to our Marital Arts School Database System!</h2>
      <p class="muted">This interface performs CRUD operations, search/filter queries, reports, and displays meaningful views directly against the MySQL database.</p>
      <div class="actions">
        <a class="link-btn" href="/students">Manage Students</a>
        <a class="link-btn" href="/enrollments">Manage Enrollments</a>
        <a class="link-btn" href="/reports">Open Reports</a>
      </div>
    </div>
  `;
  res.send(pageTemplate('Dashboard', body));
});

app.get('/students', async (req, res) => {
  const search = req.query.search || '';
  const [students] = await pool.query(
    `SELECT * FROM Students WHERE sname LIKE ? ORDER BY StudentID`,
    [`%${search}%`]
  );

  const rows = students.map(s => [
    escapeHtml(s.StudentID),
    escapeHtml(s.sname),
    escapeHtml(s.DOB),
    escapeHtml(s.phone),
    escapeHtml(s.address),
    `<div class="actions">
      <form class="inline" method="POST" action="/students/update">
        <input type="hidden" name="StudentID" value="${s.StudentID}">
        <input type="hidden" name="sname" value="${escapeHtml(s.sname)}">
        <input type="hidden" name="DOB" value="${escapeHtml(s.DOB)}">
        <input type="hidden" name="phone" value="${escapeHtml(s.phone)}">
        <input type="hidden" name="address" value="${escapeHtml(s.address)}">
      </form>
      <form class="inline" method="POST" action="/students/delete" onsubmit="return confirm('Delete this student?')">
        <input type="hidden" name="StudentID" value="${s.StudentID}">
        <button class="danger">Delete</button>
      </form>
    </div>`
  ]);

  const body = `
    <h1>Students</h1>
    ${alertBox(req)}
    <div class="grid">
      <div class="card">
        <h2>Add Student</h2>
        <form method="POST" action="/students/add">
          <div class="form-grid">
            <input name="sname" placeholder="Student Name" required>
            <input name="DOB" type="date" required>
            <input name="phone" placeholder="Phone">
            <input name="address" placeholder="Address">
          </div>
          <button type="submit">Add Student</button>
        </form>
      </div>
      <div class="card">
        <h2>Search Students</h2>
        <form method="GET" action="/students">
          <div class="form-grid">
            <input name="search" value="${escapeHtml(search)}" placeholder="Search by name">
          </div>
          <button type="submit">Search</button>
        </form>
      </div>
    </div>
    <div class="card section-gap">
      <h2>Update Student</h2>
      <form method="POST" action="/students/update">
        <div class="form-grid">
          <input name="StudentID" type="number" placeholder="Student ID" required>
          <input name="sname" placeholder="Updated Name" required>
          <input name="DOB" type="date" required>
          <input name="phone" placeholder="Updated Phone">
          <input name="address" placeholder="Updated Address">
        </div>
        <button type="submit">Update Student</button>
      </form>
    </div>
    <div class="section-gap">
      ${renderTable(['ID', 'Name', 'DOB', 'Phone', 'Address', 'Actions'], rows)}
    </div>
  `;
  res.send(pageTemplate('Students', body));
});

app.post('/students/add', async (req, res) => {
  const { sname, DOB, phone, address } = req.body;
  await pool.query(
    'INSERT INTO Students (sname, DOB, phone, address) VALUES (?, ?, ?, ?)',
    [sname, DOB, phone || null, address || null]
  );
  redirectWithMessage(res, '/students', 'Student added successfully.');
});

app.post('/students/update', async (req, res) => {
  const { StudentID, sname, DOB, phone, address } = req.body;
  await pool.query(
    'UPDATE Students SET sname = ?, DOB = ?, phone = ?, address = ? WHERE StudentID = ?',
    [sname, DOB, phone || null, address || null, StudentID]
  );
  redirectWithMessage(res, '/students', 'Student updated successfully.');
});

app.post('/students/delete', async (req, res) => {
  await pool.query('DELETE FROM Students WHERE StudentID = ?', [req.body.StudentID]);
  redirectWithMessage(res, '/students', 'Student deleted successfully.');
});

app.get('/instructors', async (req, res) => {
  const [instructors] = await pool.query('SELECT * FROM Instructors ORDER BY InstructorID');
  const rows = instructors.map(i => [
    escapeHtml(i.InstructorID),
    escapeHtml(i.iname),
    escapeHtml(i.DOB),
    escapeHtml(i.phone),
    escapeHtml(i.address),
    `<form class="inline" method="POST" action="/instructors/delete" onsubmit="return confirm('Delete this instructor?')">
      <input type="hidden" name="InstructorID" value="${i.InstructorID}">
      <button class="danger">Delete</button>
    </form>`
  ]);
  const body = `
    <h1>Instructors</h1>
    ${alertBox(req)}
    <div class="grid">
      <div class="card">
        <h2>Add Instructor</h2>
        <form method="POST" action="/instructors/add">
          <div class="form-grid">
            <input name="iname" placeholder="Instructor Name" required>
            <input name="DOB" type="date" required>
            <input name="phone" placeholder="Phone">
            <input name="address" placeholder="Address">
          </div>
          <button>Add Instructor</button>
        </form>
      </div>
      <div class="card">
        <h2>Update Instructor</h2>
        <form method="POST" action="/instructors/update">
          <div class="form-grid">
            <input name="InstructorID" type="number" placeholder="Instructor ID" required>
            <input name="iname" placeholder="Updated Name" required>
            <input name="DOB" type="date" required>
            <input name="phone" placeholder="Updated Phone">
            <input name="address" placeholder="Updated Address">
          </div>
          <button>Update Instructor</button>
        </form>
      </div>
    </div>
    <div class="section-gap">${renderTable(['ID', 'Name', 'DOB', 'Phone', 'Address', 'Delete'], rows)}</div>
  `;
  res.send(pageTemplate('Instructors', body));
});

app.post('/instructors/add', async (req, res) => {
  const { iname, DOB, phone, address } = req.body;
  await pool.query(
    'INSERT INTO Instructors (iname, DOB, phone, address) VALUES (?, ?, ?, ?)',
    [iname, DOB, phone || null, address || null]
  );
  redirectWithMessage(res, '/instructors', 'Instructor added successfully.');
});

app.post('/instructors/update', async (req, res) => {
  const { InstructorID, iname, DOB, phone, address } = req.body;
  await pool.query(
    'UPDATE Instructors SET iname = ?, DOB = ?, phone = ?, address = ? WHERE InstructorID = ?',
    [iname, DOB, phone || null, address || null, InstructorID]
  );
  redirectWithMessage(res, '/instructors', 'Instructor updated successfully.');
});

app.post('/instructors/delete', async (req, res) => {
  await pool.query('DELETE FROM Instructors WHERE InstructorID = ?', [req.body.InstructorID]);
  redirectWithMessage(res, '/instructors', 'Instructor deleted successfully.');
});

app.get('/martial-arts', async (req, res) => {
  const [martialArts] = await pool.query('SELECT * FROM MartialArts ORDER BY MAID');
  const rows = martialArts.map(m => [
    escapeHtml(m.MAID),
    escapeHtml(m.name),
    `<form class="inline" method="POST" action="/martial-arts/delete" onsubmit="return confirm('Delete this class offering?')">
      <input type="hidden" name="MAID" value="${m.MAID}">
      <button class="danger">Delete</button>
    </form>`
  ]);
  const body = `
    <h1>Classes</h1>
    ${alertBox(req)}
    <div class="grid">
      <div class="card">
        <h2>Add Offering</h2>
        <form method="POST" action="/martial-arts/add">
          <input name="name" placeholder="Class Name" required>
          <button>Add</button>
        </form>
      </div>
      <div class="card">
        <h2>Update Offering</h2>
        <form method="POST" action="/martial-arts/update">
          <div class="form-grid">
            <input name="MAID" type="number" placeholder="Offering ID" required>
            <input name="name" placeholder="Updated Class Name" required>
          </div>
          <button>Update</button>
        </form>
      </div>
    </div>
    <div class="section-gap">${renderTable(['ID', 'Class Name', 'Delete'], rows)}</div>
  `;
  res.send(pageTemplate('Classes', body));
});

app.post('/martial-arts/add', async (req, res) => {
  await pool.query('INSERT INTO MartialArts (name) VALUES (?)', [req.body.name]);
  redirectWithMessage(res, '/martial-arts', 'Class offering added successfully.');
});

app.post('/martial-arts/update', async (req, res) => {
  await pool.query('UPDATE MartialArts SET name = ? WHERE MAID = ?', [req.body.name, req.body.MAID]);
  redirectWithMessage(res, '/martial-arts', 'Class offering updated successfully.');
});

app.post('/martial-arts/delete', async (req, res) => {
  await pool.query('DELETE FROM MartialArts WHERE MAID = ?', [req.body.MAID]);
  redirectWithMessage(res, '/martial-arts', 'Class offering deleted successfully.');
});

app.get('/ranks', async (req, res) => {
  const [ranks] = await pool.query(`
    SELECT r.RankID, r.RankName, r.level, r.MAID, m.name AS ClassName
    FROM Ranks r
    JOIN MartialArts m ON r.MAID = m.MAID
    ORDER BY m.name, r.level
  `);
  const [martialArts] = await pool.query('SELECT * FROM MartialArts ORDER BY name');
  const options = martialArts.map(m => `<option value="${m.MAID}">${escapeHtml(m.name)}</option>`).join('');
  const rows = ranks.map(r => [
    escapeHtml(r.RankID),
    escapeHtml(r.ClassName),
    escapeHtml(r.RankName),
    escapeHtml(r.level),
    `<form class="inline" method="POST" action="/ranks/delete" onsubmit="return confirm('Delete this rank?')">
      <input type="hidden" name="RankID" value="${r.RankID}">
      <button class="danger">Delete</button>
    </form>`
  ]);
  const body = `
    <h1>Ranks</h1>
    ${alertBox(req)}
    <div class="grid">
      <div class="card">
        <h2>Add Rank</h2>
        <form method="POST" action="/ranks/add">
          <div class="form-grid">
            <select name="MAID" required>${options}</select>
            <input name="RankName" placeholder="Rank Name" required>
            <input name="level" type="number" min="1" placeholder="Level" required>
          </div>
          <button>Add Rank</button>
        </form>
      </div>
      <div class="card">
        <h2>Update Rank</h2>
        <form method="POST" action="/ranks/update">
          <div class="form-grid">
            <input name="RankID" type="number" placeholder="Rank ID" required>
            <input name="RankName" placeholder="Updated Rank Name" required>
            <input name="level" type="number" min="1" placeholder="Updated Level" required>
          </div>
          <button>Update Rank</button>
        </form>
      </div>
    </div>
    <div class="section-gap">${renderTable(['Rank ID', 'Class Offering', 'Rank', 'Level', 'Delete'], rows)}</div>
  `;
  res.send(pageTemplate('Ranks', body));
});

app.post('/ranks/add', async (req, res) => {
  const { MAID, RankName, level } = req.body;
  await pool.query('INSERT INTO Ranks (MAID, RankName, level) VALUES (?, ?, ?)', [MAID, RankName, level]);
  redirectWithMessage(res, '/ranks', 'Rank added successfully.');
});

app.post('/ranks/update', async (req, res) => {
  const { RankID, RankName, level } = req.body;
  await pool.query('UPDATE Ranks SET RankName = ?, level = ? WHERE RankID = ?', [RankName, level, RankID]);
  redirectWithMessage(res, '/ranks', 'Rank updated successfully.');
});

app.post('/ranks/delete', async (req, res) => {
  await pool.query('DELETE FROM Ranks WHERE RankID = ?', [req.body.RankID]);
  redirectWithMessage(res, '/ranks', 'Rank deleted successfully.');
});

app.get('/enrollments', async (req, res) => {
  const [enrollments] = await pool.query(`
    SELECT e.StudentID, s.sname, e.MAID, m.name AS ClassName, e.Enroll_Date
    FROM Enrolled e
    JOIN Students s ON e.StudentID = s.StudentID
    JOIN MartialArts m ON e.MAID = m.MAID
    ORDER BY e.Enroll_Date DESC, s.sname
  `);
  const [students] = await pool.query('SELECT StudentID, sname FROM Students ORDER BY sname');
  const [martialArts] = await pool.query('SELECT MAID, name FROM MartialArts ORDER BY name');
  const studentOptions = students.map(s => `<option value="${s.StudentID}">${escapeHtml(s.sname)} (ID ${s.StudentID})</option>`).join('');
  const classOptions = martialArts.map(m => `<option value="${m.MAID}">${escapeHtml(m.name)} (ID ${m.MAID})</option>`).join('');
  const rows = enrollments.map(e => [
    escapeHtml(e.StudentID),
    escapeHtml(e.sname),
    escapeHtml(e.MAID),
    escapeHtml(e.ClassName),
    escapeHtml(e.Enroll_Date),
    `<form class="inline" method="POST" action="/enrollments/delete" onsubmit="return confirm('Delete this enrollment?')">
      <input type="hidden" name="StudentID" value="${e.StudentID}">
      <input type="hidden" name="MAID" value="${e.MAID}">
      <button class="danger">Delete</button>
    </form>`
  ]);
  const body = `
    <h1>Enrollments</h1>
    ${alertBox(req)}
    <div class="grid">
      <div class="card">
        <h2>Add Enrollment</h2>
        <form method="POST" action="/enrollments/add">
          <div class="form-grid">
            <select name="StudentID" required>${studentOptions}</select>
            <select name="MAID" required>${classOptions}</select>
            <input name="Enroll_Date" type="date" required>
          </div>
          <button>Add Enrollment</button>
        </form>
      </div>
      <div class="card">
        <h2>Update Enrollment Date</h2>
        <form method="POST" action="/enrollments/update">
          <div class="form-grid">
            <select name="StudentID" required>${studentOptions}</select>
            <select name="MAID" required>${classOptions}</select>
            <input name="Enroll_Date" type="date" required>
          </div>
          <button>Update Enrollment</button>
        </form>
      </div>
    </div>
    <div class="section-gap">${renderTable(['Student ID', 'Student', 'Class ID', 'Class Name', 'Enrollment Date', 'Delete'], rows)}</div>
  `;
  res.send(pageTemplate('Enrollments', body));
});

app.post('/enrollments/add', async (req, res) => {
  const { StudentID, MAID, Enroll_Date } = req.body;
  await pool.query('INSERT INTO Enrolled (StudentID, MAID, Enroll_Date) VALUES (?, ?, ?)', [StudentID, MAID, Enroll_Date]);
  redirectWithMessage(res, '/enrollments', 'Enrollment added successfully.');
});

app.post('/enrollments/update', async (req, res) => {
  const { StudentID, MAID, Enroll_Date } = req.body;
  await pool.query('UPDATE Enrolled SET Enroll_Date = ? WHERE StudentID = ? AND MAID = ?', [Enroll_Date, StudentID, MAID]);
  redirectWithMessage(res, '/enrollments', 'Enrollment updated successfully.');
});

app.post('/enrollments/delete', async (req, res) => {
  const { StudentID, MAID } = req.body;
  await pool.query('DELETE FROM Enrolled WHERE StudentID = ? AND MAID = ?', [StudentID, MAID]);
  redirectWithMessage(res, '/enrollments', 'Enrollment deleted successfully.');
});

app.get('/teaches', async (req, res) => {
  const [assignments] = await pool.query(`
    SELECT t.InstructorID, i.iname, t.MAID, m.name AS ClassName
    FROM Teaches t
    JOIN Instructors i ON t.InstructorID = i.InstructorID
    JOIN MartialArts m ON t.MAID = m.MAID
    ORDER BY i.iname, m.name
  `);
  const [instructors] = await pool.query('SELECT InstructorID, iname FROM Instructors ORDER BY iname');
  const [martialArts] = await pool.query('SELECT MAID, name FROM MartialArts ORDER BY name');
  const instructorOptions = instructors.map(i => `<option value="${i.InstructorID}">${escapeHtml(i.iname)} (ID ${i.InstructorID})</option>`).join('');
  const classOptions = martialArts.map(m => `<option value="${m.MAID}">${escapeHtml(m.name)} (ID ${m.MAID})</option>`).join('');
  const rows = assignments.map(a => [
    escapeHtml(a.InstructorID),
    escapeHtml(a.iname),
    escapeHtml(a.MAID),
    escapeHtml(a.ClassName),
    `<form class="inline" method="POST" action="/teaches/delete" onsubmit="return confirm('Delete this teaching assignment?')">
      <input type="hidden" name="InstructorID" value="${a.InstructorID}">
      <input type="hidden" name="MAID" value="${a.MAID}">
      <button class="danger">Delete</button>
    </form>`
  ]);
  const body = `
    <h1>Teaching Assignments</h1>
    ${alertBox(req)}
    <div class="grid">
      <div class="card">
        <h2>Assign Instructor</h2>
        <form method="POST" action="/teaches/add">
          <div class="form-grid">
            <select name="InstructorID" required>${instructorOptions}</select>
            <select name="MAID" required>${classOptions}</select>
          </div>
          <button>Add Assignment</button>
        </form>
      </div>
    </div>
    <div class="section-gap">${renderTable(['Instructor ID', 'Instructor', 'Class ID', 'Class Name', 'Delete'], rows)}</div>
  `;
  res.send(pageTemplate('Teaching Assignments', body));
});

app.post('/teaches/add', async (req, res) => {
  const { InstructorID, MAID } = req.body;
  await pool.query('INSERT INTO Teaches (InstructorID, MAID) VALUES (?, ?)', [InstructorID, MAID]);
  redirectWithMessage(res, '/teaches', 'Teaching assignment added successfully.');
});

app.post('/teaches/delete', async (req, res) => {
  const { InstructorID, MAID } = req.body;
  await pool.query('DELETE FROM Teaches WHERE InstructorID = ? AND MAID = ?', [InstructorID, MAID]);
  redirectWithMessage(res, '/teaches', 'Teaching assignment deleted successfully.');
});

app.get('/reports', async (req, res) => {
  const [[report1], [report2], [report3], [report4], [report5]] = await Promise.all([
    pool.query(`
      SELECT m.MAID, m.name AS ClassName, COUNT(e.StudentID) AS TotalStudents
      FROM MartialArts m
      LEFT JOIN Enrolled e ON m.MAID = e.MAID
      GROUP BY m.MAID, m.name
      ORDER BY TotalStudents DESC
    `),
    pool.query(`
      SELECT m.MAID, m.name AS ClassName, COUNT(t.InstructorID) AS TotalInstructors
      FROM MartialArts m
      LEFT JOIN Teaches t ON m.MAID = t.MAID
      GROUP BY m.MAID, m.name
      ORDER BY TotalInstructors DESC
    `),
    pool.query(`
      SELECT m.name AS ClassName, r.RankName, r.level
      FROM MartialArts m
      JOIN Ranks r ON m.MAID = r.MAID
      ORDER BY m.name, r.level
    `),
    pool.query(`
      SELECT s.StudentID, s.sname, m.name AS ClassName, e.Enroll_Date
      FROM Students s
      JOIN Enrolled e ON s.StudentID = e.StudentID
      JOIN MartialArts m ON e.MAID = m.MAID
      ORDER BY s.sname, m.name
    `),
    pool.query(`
      SELECT i.InstructorID, i.iname, m.name AS ClassName
      FROM Instructors i
      JOIN Teaches t ON i.InstructorID = t.InstructorID
      JOIN MartialArts m ON t.MAID = m.MAID
      ORDER BY i.iname, m.name
    `),
  ]);

  const body = `
    <h1>Reports</h1>
    <div class="card"><h2>Students per Class Offering</h2>${renderTable(['Class ID', 'Class Name', 'Total Students'], report1.map(r => [escapeHtml(r.MAID), escapeHtml(r.ClassName), escapeHtml(r.TotalStudents)]))}</div>
    <div class="card section-gap"><h2>Instructors per Class Offering</h2>${renderTable(['Class ID', 'Class Name', 'Total Instructors'], report2.map(r => [escapeHtml(r.MAID), escapeHtml(r.ClassName), escapeHtml(r.TotalInstructors)]))}</div>
    <div class="card section-gap"><h2>Ranks by Class Offering</h2>${renderTable(['Class Name', 'Rank Name', 'Level'], report3.map(r => [escapeHtml(r.ClassName), escapeHtml(r.RankName), escapeHtml(r.level)]))}</div>
    <div class="card section-gap"><h2>Student Enrollments</h2>${renderTable(['Student ID', 'Student', 'Class Name', 'Enrollment Date'], report4.map(r => [escapeHtml(r.StudentID), escapeHtml(r.sname), escapeHtml(r.ClassName), escapeHtml(r.Enroll_Date)]))}</div>
    <div class="card section-gap"><h2>Instructor Assignments</h2>${renderTable(['Instructor ID', 'Instructor', 'Class Name'], report5.map(r => [escapeHtml(r.InstructorID), escapeHtml(r.iname), escapeHtml(r.ClassName)]))}</div>
  `;
  res.send(pageTemplate('Reports', body));
});

app.get('/views', async (req, res) => {
  const [studentEnrollmentView] = await pool.query('SELECT * FROM StudentEnrollmentView ORDER BY StudentID, ClassName');
  const [instructorAssignmentView] = await pool.query('SELECT * FROM InstructorAssignmentView ORDER BY InstructorID, ClassName');

  const body = `
    <h1>Views</h1>
    <div class="card">
      <h2>StudentEnrollmentView</h2>
      ${renderTable(
        ['Student ID', 'Student', 'Class ID', 'Class Name', 'Enrollment Date'],
        studentEnrollmentView.map(v => [escapeHtml(v.StudentID), escapeHtml(v.sname), escapeHtml(v.MAID), escapeHtml(v.ClassName), escapeHtml(v.Enroll_Date)])
      )}
    </div>
    <div class="card section-gap">
      <h2>InstructorAssignmentView</h2>
      ${renderTable(
        ['Instructor ID', 'Instructor', 'Class ID', 'Class Name'],
        instructorAssignmentView.map(v => [escapeHtml(v.InstructorID), escapeHtml(v.iname), escapeHtml(v.MAID), escapeHtml(v.ClassName)])
      )}
    </div>
  `;
  res.send(pageTemplate('Views', body));
});

app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).send(pageTemplate('Error', `<h1>Something went wrong</h1><div class="card"><p>${escapeHtml(err.message)}</p><p class="muted">Check your database connection, schema, and any duplicate insert values.</p></div>`));
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
