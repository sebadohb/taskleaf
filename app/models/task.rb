class Task < ApplicationRecord
  def self.csv_attributes
    ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{|attr|  task.send(attr)}
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row| #受け取ったCSVファイルを行ごとに取り出す、その時1行目headerには項目が書いてあるので、1行目は無視する
      task = new #Task.newと同価
      task.attributes = row.to_hash.slice(*csv_attributes) #taskの属性に順番にデータを格納していく。詳しくは調べてください
      task.save!
    end
  end

  def self.ransackable_attribute(auth_object = nil)
    %w[name created_at]
  end
  def self.ransackable_attribute(auth_object = nil)
    []
  end
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_including_comma
  belongs_to :user
  has_one_attached :image

  
  scope :recent, -> { order(created_at: :desc)}


  private
  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含める事はできません') if name&.include?(',')
  end
end
