const { sequelize, models } = require("../models"); // Import sequelize instance và models từ index.js

const seedDatabase = async () => {
  try {
    // Đồng bộ cơ sở dữ liệu (force: true để xóa và tạo lại bảng)
    await sequelize.sync({ force: true });

    console.log("Cơ sở dữ liệu đã được đồng bộ!");

    // --- Seed dữ liệu phân cấp sinh học ---
    const kingdom = await models.Kingdom.create({ name: "Động vật" });
    const phylum = await models.Phylum.create({ name: "Động vật có dây sống", kingdom_id: kingdom.id });
    const classMammalia = await models.Class.create({ name: "Lớp Thú", phylum_id: phylum.id });
    const orderCarnivora = await models.Order.create({ name: "Bộ Ăn Thịt", class_id: classMammalia.id });
    const familyFelidae = await models.Family.create({ name: "Họ Mèo", order_id: orderCarnivora.id });
    const genusPanthera = await models.Genus.create({ name: "Chi Báo", family_id: familyFelidae.id });
    const speciesLion = await models.Species.create({
      scientific_name: "Panthera leo",
      common_name: "Sư tử",
      genus_id: genusPanthera.id,
    });

    const genusFelis = await models.Genus.create({ name: "Chi Mèo", family_id: familyFelidae.id });
    const speciesCat = await models.Species.create({
      scientific_name: "Felis catus",
      common_name: "Mèo nhà",
      genus_id: genusFelis.id,
    });

    // Thêm Kingdom mới
    const kingdomPlantae = await models.Kingdom.create({ name: "Thực vật" });
    const phylumMagnoliophyta = await models.Phylum.create({ name: "Ngành Ngọc Lan", kingdom_id: kingdomPlantae.id });
    const classMagnoliopsida = await models.Class.create({ name: "Lớp Ngọc Lan", phylum_id: phylumMagnoliophyta.id });
    const orderRosales = await models.Order.create({ name: "Bộ Hoa Hồng", class_id: classMagnoliopsida.id });
    const familyRosaceae = await models.Family.create({ name: "Họ Hoa Hồng", order_id: orderRosales.id });
    const genusRosa = await models.Genus.create({ name: "Chi Hoa Hồng", family_id: familyRosaceae.id });
    const speciesRose = await models.Species.create({
      scientific_name: "Rosa gallica",
      common_name: "Hoa hồng Pháp",
      genus_id: genusRosa.id,
    });

    const genusQuercus = await models.Genus.create({ name: "Chi Sồi", family_id: familyRosaceae.id });
    const speciesOak = await models.Species.create({
      scientific_name: "Quercus robur",
      common_name: "Cây sồi",
      genus_id: genusQuercus.id,
    });

    // --- Seed Nhóm Sinh Vật ---
    const groupMammals = await models.OrganismGroup.create({ name: "Động vật có vú", symbol: "MAM" });
    const groupCarnivores = await models.OrganismGroup.create({ name: "Động vật ăn thịt", symbol: "CAR" });

    // Gắn Species với Nhóm Sinh Vật
    await models.OrganismGroupSpecies.create({ organism_group_id: groupMammals.id, species_id: speciesLion.id });
    await models.OrganismGroupSpecies.create({ organism_group_id: groupCarnivores.id, species_id: speciesLion.id });

    // --- Seed Môi Trường Sống ---
    const habitatSavanna = await models.Habitat.create({
      name: "Xavan",
      description: "Thảo nguyên có cây cối rải rác.",
      climate: "Ấm áp",
      temperature: 25.0,
      humidity: 60,
    });
    const habitatForest = await models.Habitat.create({
      name: "Rừng Nhiệt Đới",
      description: "Rừng rậm và ẩm ướt.",
      climate: "Ẩm",
      temperature: 30.0,
      humidity: 80,
    });
    const habitatDesert = await models.Habitat.create({
      name: "Sa mạc",
      description: "Khu vực nóng và khô hạn với thảm thực vật thưa thớt.",
      climate: "Khô hạn",
      temperature: 40.0,
      humidity: 15,
    });

    // Gắn Môi Trường Sống với Loài
    await models.SpeciesHabitat.create({ species_id: speciesLion.id, habitat_id: habitatSavanna.id });
    await models.SpeciesHabitat.create({ species_id: speciesLion.id, habitat_id: habitatForest.id });
    await models.SpeciesHabitat.create({ species_id: speciesRose.id, habitat_id: habitatDesert.id });
    await models.SpeciesHabitat.create({ species_id: speciesOak.id, habitat_id: habitatForest.id });

    // --- Seed Đặc Điểm ---
    await models.Characteristic.create({
      species_id: speciesLion.id,
      characteristic_type: "Chiều dài cơ thể",
      value: "1.8-2.1",
      units: "mét",
    });
    await models.Characteristic.create({
      species_id: speciesLion.id,
      characteristic_type: "Trọng lượng",
      value: "150-225",
      units: "kg",
    });

    await models.Characteristic.create({
      species_id: speciesCat.id,
      characteristic_type: "Trọng lượng",
      value: "3-6",
      units: "kg",
    });

    // --- Seed Phân Bố Địa Lý ---
    await models.GeographicDistribution.create({
      species_id: speciesLion.id,
      region: "Châu Phi",
      country: "Kenya",
      location: "Masai Mara",
      notes: "Sống trong bầy lớn.",
    });
    await models.GeographicDistribution.create({
      species_id: speciesRose.id,
      region: "Châu Âu",
      country: "Pháp",
      location: "Miền Nam nước Pháp",
      notes: "Được trồng làm cây cảnh.",
    });
    await models.GeographicDistribution.create({
      species_id: speciesOak.id,
      region: "Châu Âu",
      country: "Anh",
      location: "Rừng Sherwood",
      notes: "Loài cây phổ biến trong các khu rừng rộng lớn.",
    });

    // --- Seed Tác Giả ---
    const authorJane = await models.Author.create({ name: "Jane Doe", affiliation: "Đại học Động vật Hoang dã" });
    const authorJohn = await models.Author.create({ name: "John Smith", affiliation: "Viện Nghiên cứu Châu Phi" });

    // Gắn Tác Giả với Loài
    await models.SpeciesAuthor.create({ species_id: speciesLion.id, author_id: authorJane.id });
    await models.SpeciesAuthor.create({ species_id: speciesLion.id, author_id: authorJohn.id });

    // --- Seed Tình Trạng Bảo Tồn ---
    await models.ConservationStatus.create({
      species_id: speciesLion.id,
      name: "Bảo tồn Sư tử",
      severity: "Dễ tổn thương",
      description: "Số lượng đang giảm do mất môi trường sống.",
    });

    console.log("Toàn bộ dữ liệu đã được seed thành công!");
  } catch (error) {
    console.error("Lỗi khi seed dữ liệu:", error);
  }
  // finally {
  //   await sequelize.close();
  // }
};

module.exports = seedDatabase;
