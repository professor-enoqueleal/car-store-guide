package br.com.carsoft.util;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class ObjectMapper {

    private static Gson gson = new Gson();

    public static <T> T transformRequestToObject(HttpServletRequest request, Class<T> classType) {

        JsonObject parameters = new JsonObject();

        for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
            parameters.addProperty(entry.getKey(), entry.getValue()[0]);
        }

        return gson.fromJson(parameters, classType);

    }

}
