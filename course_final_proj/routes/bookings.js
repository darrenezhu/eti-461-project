const express = require('express');
const router = express.Router();
const db = require('../database');

router.post('/addBooking', async (req, res) => {
    const { startDate, endDate, guestID, listingID } = req.body;
    try {
        const [result] = await db.query(`
            INSERT INTO Booking (startDate, endDate, guestID, listingID)
            VALUES (?, ?, ?, ?)
        `,
            [startDate, endDate, guestID, listingID]
        );
        res.json({ success: true, message: 'Booking successfully added' });
    } catch (err) {
        console.error(err);
        res.status(500).send({ success: false, message: 'Error adding booking' });
    }
});

module.exports = router;
