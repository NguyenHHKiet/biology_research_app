const advancedResults =
  (model, options = {}) =>
  async (req, res, next) => {
    try {
      const { include = [], where = {}, attributes = null } = options;

      // Copy req.query
      const reqQuery = { ...req.query };

      // Fields to exclude
      const removeFields = ["select", "sort", "page", "limit"];
      removeFields.forEach(param => delete reqQuery[param]);

      // Advanced filtering (e.g., gt, gte, lt, lte)
      for (const [key, value] of Object.entries(reqQuery)) {
        if (/^(gt|gte|lt|lte|in)$/.test(key)) {
          const opKey = `$${key}`;
          where[key.replace(/\[\w+\]/, "")] = { [opKey]: value };
        } else {
          where[key] = value;
        }
      }

      // Select fields
      let selectAttributes = attributes;
      if (req.query.select) {
        selectAttributes = req.query.select.split(",");
      }

      // Sort
      let order = [];
      if (req.query.sort) {
        const sortFields = req.query.sort.split(",");
        order = sortFields.map(field => (field.startsWith("-") ? [field.substring(1), "DESC"] : [field, "ASC"]));
      } else {
        // Default sort by createdAt desc
        order.push(["createdAt", "DESC"]);
      }

      // Pagination
      const page = parseInt(req.query.page, 10) || 1;
      const limit = parseInt(req.query.limit, 10) || 5;
      const offset = (page - 1) * limit;

      // Fetch data with Sequelize
      const { count, rows } = await model.findAndCountAll({
        where,
        include,
        attributes: selectAttributes,
        order,
        limit,
        offset,
      });

      // Pagination result
      const pagination = {};
      if (offset + limit < count) {
        pagination.next = {
          page: page + 1,
          limit,
        };
      }
      if (offset > 0) {
        pagination.prev = {
          page: page - 1,
          limit,
        };
      }

      res.advancedResults = {
        success: true,
        count: rows.length,
        pagination,
        data: rows,
      };

      next();
    } catch (err) {
      next(err);
    }
  };

module.exports = advancedResults;
