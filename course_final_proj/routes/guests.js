const express = require('express');
const router = express.Router();
const db = require('../database');

router.post('/addGuest', async (req, res) => {
    const { fName, lName, phone, email, addr, city, state, zip, dob, idForm, password } = req.body;
    try {
        const [result] = await db.query(`
            INSERT INTO Guest (fName, lName, phone, email, addr, city, state, zip, dob, idForm, password) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `,
            [fName, lName, phone, email, addr, city, state, zip, dob, idForm, password]
        );
        res.redirect('/index.html');
    } catch (err) {
        console.error(err);
        res.status(500).send('Error adding guest');
    }
});

module.exports = router;