class ForecastSerializer
  def initialize(forecast)
    @forecast = forecast
  end

  def serialize
    { 
      data: 
      {
        id: nil,
        type: "forecast",
        attributes:
        {
          current_weather: 
          {
            last_updated:@forecast[:current][:last_updated],
            temperature: @forecast[:current][:temp_f],
            feels_like: @forecast[:current][:feelslike_f],
            humidity: @forecast[:current][:humidity],
            uvi: @forecast[:current][:uv],
            visibility: @forecast[:current][:vis_miles],
            condition: @forecast[:current][:condition][:text],
            icon: @forecast[:current][:condition][:icon],
          },
          daily_weather: 
          [
            {
              date: @forecast[:forecast][:forecastday][0][:date],
              sunrise: @forecast[:forecast][:forecastday][0][:astro][:sunrise],
              sunset: @forecast[:forecast][:forecastday][0][:astro][:sunset],
              max_temp: @forecast[:forecast][:forecastday][0][:day][:maxtemp_f],
              min_temp: @forecast[:forecast][:forecastday][0][:day][:mintemp_f],
              condition: @forecast[:forecast][:forecastday][0][:day][:condition][:text],
              icon: @forecast[:forecast][:forecastday][0][:day][:condition][:icon],
            },
            {
              date: @forecast[:forecast][:forecastday][1][:date], 
              sunrise: @forecast[:forecast][:forecastday][1][:astro][:sunrise],
              sunset: @forecast[:forecast][:forecastday][1][:astro][:sunset],
              max_temp: @forecast[:forecast][:forecastday][1][:day][:maxtemp_f],
              min_temp: @forecast[:forecast][:forecastday][1][:day][:mintemp_f],
              condition: @forecast[:forecast][:forecastday][1][:day][:condition][:text],
              icon: @forecast[:forecast][:forecastday][1][:day][:condition][:icon],
            },
            {
              date: @forecast[:forecast][:forecastday][2][:date],
              sunrise: @forecast[:forecast][:forecastday][2][:astro][:sunrise],
              sunset: @forecast[:forecast][:forecastday][2][:astro][:sunset],
              max_temp: @forecast[:forecast][:forecastday][2][:day][:maxtemp_f],
              min_temp: @forecast[:forecast][:forecastday][2][:day][:mintemp_f],
              condition: @forecast[:forecast][:forecastday][2][:day][:condition][:text],
              icon: @forecast[:forecast][:forecastday][2][:day][:condition][:icon],
            },
            {
              date: @forecast[:forecast][:forecastday][3][:date], 
              sunrise: @forecast[:forecast][:forecastday][3][:astro][:sunrise],
              sunset: @forecast[:forecast][:forecastday][3][:astro][:sunset],
              max_temp: @forecast[:forecast][:forecastday][3][:day][:maxtemp_f],
              min_temp: @forecast[:forecast][:forecastday][3][:day][:mintemp_f],
              condition: @forecast[:forecast][:forecastday][3][:day][:condition][:text],
              icon: @forecast[:forecast][:forecastday][3][:day][:condition][:icon],
            },
            {
              date: @forecast[:forecast][:forecastday][4][:date], 
              sunrise: @forecast[:forecast][:forecastday][4][:astro][:sunrise],
              sunset: @forecast[:forecast][:forecastday][4][:astro][:sunset],
              max_temp: @forecast[:forecast][:forecastday][4][:day][:maxtemp_f],
              min_temp: @forecast[:forecast][:forecastday][4][:day][:mintemp_f],
              condition: @forecast[:forecast][:forecastday][4][:day][:condition][:text],
              icon: @forecast[:forecast][:forecastday][4][:day][:condition][:icon],
            }
          ],

          hourly_weather:
          @forecast[:forecast][:forecastday][0][:hour].map do |hour|
            {
              time: hour[:time],
              temperature: hour[:temp_f],
              condition: hour[:condition][:text],
              icon: hour[:condition][:icon]
            }
          end
        }
      }
    }
  end

end