function e = rot2eul(R)

e = zeros(3,1);
e(1) = atan2(R(3,2),R(3,3));
e(2) = -asin(R(3,1));
e(3) = atan2(R(2,1),R(1,1));

end