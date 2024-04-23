const express = require('express');
const router = express.Router();
const db = require('../database');

router.get('/:id', async function(req, res, next) {
    try {
        const sqlQuery = `
            SELECT Listing.*, Host.hostFName, PropertyType.propertyType, Location.*,
            GROUP_CONCAT(Amenities.amenity SEPARATOR ', ') AS amenities
            FROM Listing
            JOIN Host ON Listing.hostID = Host.hostID
            JOIN PropertyType ON Listing.propertyTypeID = PropertyType.propertyTypeID
            JOIN ListingAmenities ON Listing.listingID = ListingAmenities.listingID
            JOIN Amenities ON ListingAmenities.amenitiesID = Amenities.amenitiesID
            JOIN Location ON Listing.locationID = Location.locationID
            WHERE Listing.listingID = ?
            GROUP BY Listing.listingID;
        `;

        const [rows] = await db.query(sqlQuery, [req.params.id]);
        if (rows.length > 0) {
            res.json(rows[0]);
        } else {
            res.status(404).send('Listing not found');
        }
    } catch (err) {
        next(err);
    }
});

module.exports = router;
