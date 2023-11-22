db.messages.aggregate([
  {
    $match: {
      body: { $regex: /паровоз/i },
    },
  },
  {
    $group: {
      _id: null,
      count: {
        $sum: 1,
      },
    },
  },
]);
