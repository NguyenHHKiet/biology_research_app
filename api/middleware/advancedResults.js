const advancedResults =
  (model, options = {}) =>
  async (req, res, next) => {
    try {
      const { include = [], where = {}, attributes = null } = options;

      // Clone query parameters
      const reqQuery = { ...req.query };

      // Fields to exclude from filtering
      const removeFields = ["select", "sort", "page", "limit"];
      removeFields.forEach(field => delete reqQuery[field]);

      // Advanced filtering (e.g., gt, gte, lt, lte, in)
      for (const [key, value] of Object.entries(reqQuery)) {
        const match = key.match(/\[(gt|gte|lt|lte|in)\]/);
        if (match) {
          const opKey = `$${match[1]}`;
          where[key.replace(/\[.+\]/, "")] = { [opKey]: value };
        } else {
          where[key] = value;
        }
      }

      // Select fields
      let selectAttributes = attributes;
      if (req.query.select) {
        selectAttributes = req.query.select.split(",");
      }

      // Sorting
      let order = [];
      if (req.query.sort) {
        order = req.query.sort
          .split(",")
          .map(field => (field.startsWith("-") ? [field.slice(1), "DESC"] : [field, "ASC"]));
      } else {
        order.push(["createdAt", "DESC"]); // Default sort by createdAt
      }

      // Pagination
      const page = parseInt(req.query.page, 10) || 1;
      const limit = parseInt(req.query.limit, 10) || 10;
      const offset = (page - 1) * limit;

      // Query using Sequelize
      const { count, rows } = await model.findAndCountAll({
        where,
        include,
        attributes: selectAttributes,
        order,
        limit,
        offset,
      });

      // Prepare pagination response
      const pagination = {};
      if (offset + limit < count) {
        pagination.next = { page: page + 1, limit };
      }
      if (offset > 0) {
        pagination.prev = { page: page - 1, limit };
      }

      res.advancedResults = {
        success: true,
        count,
        pagination,
        data: rows,
      };

      next();
    } catch (err) {
      next(err);
    }
  };

module.exports = advancedResults;
