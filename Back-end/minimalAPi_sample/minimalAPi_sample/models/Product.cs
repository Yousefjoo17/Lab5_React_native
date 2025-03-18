using System.ComponentModel.DataAnnotations;

namespace minimalAPi_sample.models
{
    public class Product
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }

        public string url { get; set; }
        public float price { get; set; }

    }
}
