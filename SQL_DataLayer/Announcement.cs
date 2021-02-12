using System;

namespace DataLayer_Test
{
    public class Announcement
    {
        #region Properties
        public Guid AnnoucementID { get; set; }
        public Guid UserID { get; set; }
        public int VehicleType { get; set; }
        public int Views { get; set; }
        public bool Promoted { get; set; }
        public bool Active { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime Update { get; set; }
        public string Condition { get; set; }
        public string Title { get; set; }
        public string Brand { get; set; }
        public string Model { get; set; }
        public string Type { get; set; }
        public int Kilometer { get; set; }
        public int FabricationYear { get; set; }
        public string VIN { get; set; }
        public string FuelType { get; set; }
        public int Price { get; set; }
        public bool NegociablePrice { get; set; }
        public string Currency { get; set; }
        public string Color { get; set; }
        public string ColorType { get; set; }
        public int Power { get; set; }
        public string Transmission { get; set; }
        public int CubicCapacity { get; set; }
        public string EmissionClass { get; set; }
        public int NumberOfSeats { get; set; }
        public int GVW { get; set; }
        public int LoadCapacity { get; set; }
        public int OperatingHours { get; set; }
        public string Description { get; set; }
        #endregion
    }
}
