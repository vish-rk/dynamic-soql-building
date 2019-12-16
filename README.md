# Dynamic SOQL building - Build SOQL in a strcutured, scalable and maintaible way.

1. Use soqlBuilder.buildSOQL() to building your dynamic string query. Covered arithmatic, like(%) and set filtering.

2. Use this only for UI controllers. Lightning/LWC (and if anybody is still stuck with Visualforce :) ). Observe soqlFilterDTO.cls.

3. The approach is to achieve loose coupling between client-side and server-side code.

4. The approach is strictly not suitable for Triggers.
