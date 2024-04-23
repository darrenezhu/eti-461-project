const express = require('express');
const router = express.Router();
const db = require('../database');

router.get('/', async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT guestID 
            FROM Guest 
            ORDER BY guestID 
            DESC LIMIT 1
        `);
        if (rows.length > 0) {
            res.json({ success: true, guestID: rows[0].guestID });
        } else {
            res.status(404).send({ success: false, message: 'No guests found' });
        }
    } catch (err) {
        console.error(err);
        res.status(500).send({ success: false, message: 'Error fetching last guest' });
    }
});

module.exports = router;