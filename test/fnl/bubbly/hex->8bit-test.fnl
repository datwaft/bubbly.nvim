(module bubbly.hex->8bit-test
  {autoload {highlight bubbly.highlight}})

(local {: hex->8bit} highlight)

(deftest equals-000000-16
  (t.= 16 (hex->8bit "#000000")
       "#000000 should equal 16"))
(deftest equals-00005F-17
  (t.= 17 (hex->8bit "#00005F")
       "#00005F should equal 17"))
(deftest equals-000087-18
  (t.= 18 (hex->8bit "#000087")
       "#000087 should equal 18"))
(deftest equals-0000AF-19
  (t.= 19 (hex->8bit "#0000AF")
       "#0000AF should equal 19"))
(deftest equals-0000D7-20
  (t.= 20 (hex->8bit "#0000D7")
       "#0000D7 should equal 20"))
(deftest equals-0000FF-21
  (t.= 21 (hex->8bit "#0000FF")
       "#0000FF should equal 21"))
(deftest equals-005F00-22
  (t.= 22 (hex->8bit "#005F00")
       "#005F00 should equal 22"))
(deftest equals-005F5F-23
  (t.= 23 (hex->8bit "#005F5F")
       "#005F5F should equal 23"))
(deftest equals-005F87-24
  (t.= 24 (hex->8bit "#005F87")
       "#005F87 should equal 24"))
(deftest equals-005FAF-25
  (t.= 25 (hex->8bit "#005FAF")
       "#005FAF should equal 25"))
(deftest equals-005FD7-26
  (t.= 26 (hex->8bit "#005FD7")
       "#005FD7 should equal 26"))
(deftest equals-005FFF-27
  (t.= 27 (hex->8bit "#005FFF")
       "#005FFF should equal 27"))
(deftest equals-008700-28
  (t.= 28 (hex->8bit "#008700")
       "#008700 should equal 28"))
(deftest equals-00875F-29
  (t.= 29 (hex->8bit "#00875F")
       "#00875F should equal 29"))
(deftest equals-008787-30
  (t.= 30 (hex->8bit "#008787")
       "#008787 should equal 30"))
(deftest equals-0087AF-31
  (t.= 31 (hex->8bit "#0087AF")
       "#0087AF should equal 31"))
(deftest equals-0087D7-32
  (t.= 32 (hex->8bit "#0087D7")
       "#0087D7 should equal 32"))
(deftest equals-0087FF-33
  (t.= 33 (hex->8bit "#0087FF")
       "#0087FF should equal 33"))
(deftest equals-00AF00-34
  (t.= 34 (hex->8bit "#00AF00")
       "#00AF00 should equal 34"))
(deftest equals-00AF5F-35
  (t.= 35 (hex->8bit "#00AF5F")
       "#00AF5F should equal 35"))
(deftest equals-00AF87-36
  (t.= 36 (hex->8bit "#00AF87")
       "#00AF87 should equal 36"))
(deftest equals-00AFAF-37
  (t.= 37 (hex->8bit "#00AFAF")
       "#00AFAF should equal 37"))
(deftest equals-00AFD7-38
  (t.= 38 (hex->8bit "#00AFD7")
       "#00AFD7 should equal 38"))
(deftest equals-00AFFF-39
  (t.= 39 (hex->8bit "#00AFFF")
       "#00AFFF should equal 39"))
(deftest equals-00D700-40
  (t.= 40 (hex->8bit "#00D700")
       "#00D700 should equal 40"))
(deftest equals-00D75F-41
  (t.= 41 (hex->8bit "#00D75F")
       "#00D75F should equal 41"))
(deftest equals-00D787-42
  (t.= 42 (hex->8bit "#00D787")
       "#00D787 should equal 42"))
(deftest equals-00D7AF-43
  (t.= 43 (hex->8bit "#00D7AF")
       "#00D7AF should equal 43"))
(deftest equals-00D7D7-44
  (t.= 44 (hex->8bit "#00D7D7")
       "#00D7D7 should equal 44"))
(deftest equals-00D7FF-45
  (t.= 45 (hex->8bit "#00D7FF")
       "#00D7FF should equal 45"))
(deftest equals-00FF00-46
  (t.= 46 (hex->8bit "#00FF00")
       "#00FF00 should equal 46"))
(deftest equals-00FF5F-47
  (t.= 47 (hex->8bit "#00FF5F")
       "#00FF5F should equal 47"))
(deftest equals-00FF87-48
  (t.= 48 (hex->8bit "#00FF87")
       "#00FF87 should equal 48"))
(deftest equals-00FFAF-49
  (t.= 49 (hex->8bit "#00FFAF")
       "#00FFAF should equal 49"))
(deftest equals-00FFD7-50
  (t.= 50 (hex->8bit "#00FFD7")
       "#00FFD7 should equal 50"))
(deftest equals-00FFFF-51
  (t.= 51 (hex->8bit "#00FFFF")
       "#00FFFF should equal 51"))
(deftest equals-5F0000-52
  (t.= 52 (hex->8bit "#5F0000")
       "#5F0000 should equal 52"))
(deftest equals-5F005F-53
  (t.= 53 (hex->8bit "#5F005F")
       "#5F005F should equal 53"))
(deftest equals-5F0087-54
  (t.= 54 (hex->8bit "#5F0087")
       "#5F0087 should equal 54"))
(deftest equals-5F00AF-55
  (t.= 55 (hex->8bit "#5F00AF")
       "#5F00AF should equal 55"))
(deftest equals-5F00D7-56
  (t.= 56 (hex->8bit "#5F00D7")
       "#5F00D7 should equal 56"))
(deftest equals-5F00FF-57
  (t.= 57 (hex->8bit "#5F00FF")
       "#5F00FF should equal 57"))
(deftest equals-5F5F00-58
  (t.= 58 (hex->8bit "#5F5F00")
       "#5F5F00 should equal 58"))
(deftest equals-5F5F5F-59
  (t.= 59 (hex->8bit "#5F5F5F")
       "#5F5F5F should equal 59"))
(deftest equals-5F5F87-60
  (t.= 60 (hex->8bit "#5F5F87")
       "#5F5F87 should equal 60"))
(deftest equals-5F5FAF-61
  (t.= 61 (hex->8bit "#5F5FAF")
       "#5F5FAF should equal 61"))
(deftest equals-5F5FD7-62
  (t.= 62 (hex->8bit "#5F5FD7")
       "#5F5FD7 should equal 62"))
(deftest equals-5F5FFF-63
  (t.= 63 (hex->8bit "#5F5FFF")
       "#5F5FFF should equal 63"))
(deftest equals-5F8700-64
  (t.= 64 (hex->8bit "#5F8700")
       "#5F8700 should equal 64"))
(deftest equals-5F875F-65
  (t.= 65 (hex->8bit "#5F875F")
       "#5F875F should equal 65"))
(deftest equals-5F8787-66
  (t.= 66 (hex->8bit "#5F8787")
       "#5F8787 should equal 66"))
(deftest equals-5F87AF-67
  (t.= 67 (hex->8bit "#5F87AF")
       "#5F87AF should equal 67"))
(deftest equals-5F87D7-68
  (t.= 68 (hex->8bit "#5F87D7")
       "#5F87D7 should equal 68"))
(deftest equals-5F87FF-69
  (t.= 69 (hex->8bit "#5F87FF")
       "#5F87FF should equal 69"))
(deftest equals-5FAF00-70
  (t.= 70 (hex->8bit "#5FAF00")
       "#5FAF00 should equal 70"))
(deftest equals-5FAF5F-71
  (t.= 71 (hex->8bit "#5FAF5F")
       "#5FAF5F should equal 71"))
(deftest equals-5FAF87-72
  (t.= 72 (hex->8bit "#5FAF87")
       "#5FAF87 should equal 72"))
(deftest equals-5FAFAF-73
  (t.= 73 (hex->8bit "#5FAFAF")
       "#5FAFAF should equal 73"))
(deftest equals-5FAFD7-74
  (t.= 74 (hex->8bit "#5FAFD7")
       "#5FAFD7 should equal 74"))
(deftest equals-5FAFFF-75
  (t.= 75 (hex->8bit "#5FAFFF")
       "#5FAFFF should equal 75"))
(deftest equals-5FD700-76
  (t.= 76 (hex->8bit "#5FD700")
       "#5FD700 should equal 76"))
(deftest equals-5FD75F-77
  (t.= 77 (hex->8bit "#5FD75F")
       "#5FD75F should equal 77"))
(deftest equals-5FD787-78
  (t.= 78 (hex->8bit "#5FD787")
       "#5FD787 should equal 78"))
(deftest equals-5FD7AF-79
  (t.= 79 (hex->8bit "#5FD7AF")
       "#5FD7AF should equal 79"))
(deftest equals-5FD7D7-80
  (t.= 80 (hex->8bit "#5FD7D7")
       "#5FD7D7 should equal 80"))
(deftest equals-5FD7FF-81
  (t.= 81 (hex->8bit "#5FD7FF")
       "#5FD7FF should equal 81"))
(deftest equals-5FFF00-82
  (t.= 82 (hex->8bit "#5FFF00")
       "#5FFF00 should equal 82"))
(deftest equals-5FFF5F-83
  (t.= 83 (hex->8bit "#5FFF5F")
       "#5FFF5F should equal 83"))
(deftest equals-5FFF87-84
  (t.= 84 (hex->8bit "#5FFF87")
       "#5FFF87 should equal 84"))
(deftest equals-5FFFAF-85
  (t.= 85 (hex->8bit "#5FFFAF")
       "#5FFFAF should equal 85"))
(deftest equals-5FFFD7-86
  (t.= 86 (hex->8bit "#5FFFD7")
       "#5FFFD7 should equal 86"))
(deftest equals-5FFFFF-87
  (t.= 87 (hex->8bit "#5FFFFF")
       "#5FFFFF should equal 87"))
(deftest equals-870000-88
  (t.= 88 (hex->8bit "#870000")
       "#870000 should equal 88"))
(deftest equals-87005F-89
  (t.= 89 (hex->8bit "#87005F")
       "#87005F should equal 89"))
(deftest equals-870087-90
  (t.= 90 (hex->8bit "#870087")
       "#870087 should equal 90"))
(deftest equals-8700AF-91
  (t.= 91 (hex->8bit "#8700AF")
       "#8700AF should equal 91"))
(deftest equals-8700D7-92
  (t.= 92 (hex->8bit "#8700D7")
       "#8700D7 should equal 92"))
(deftest equals-8700FF-93
  (t.= 93 (hex->8bit "#8700FF")
       "#8700FF should equal 93"))
(deftest equals-875F00-94
  (t.= 94 (hex->8bit "#875F00")
       "#875F00 should equal 94"))
(deftest equals-875F5F-95
  (t.= 95 (hex->8bit "#875F5F")
       "#875F5F should equal 95"))
(deftest equals-875F87-96
  (t.= 96 (hex->8bit "#875F87")
       "#875F87 should equal 96"))
(deftest equals-875FAF-97
  (t.= 97 (hex->8bit "#875FAF")
       "#875FAF should equal 97"))
(deftest equals-875FD7-98
  (t.= 98 (hex->8bit "#875FD7")
       "#875FD7 should equal 98"))
(deftest equals-875FFF-99
  (t.= 99 (hex->8bit "#875FFF")
       "#875FFF should equal 99"))
(deftest equals-878700-100
  (t.= 100 (hex->8bit "#878700")
       "#878700 should equal 100"))
(deftest equals-87875F-101
  (t.= 101 (hex->8bit "#87875F")
       "#87875F should equal 101"))
(deftest equals-878787-102
  (t.= 102 (hex->8bit "#878787")
       "#878787 should equal 102"))
(deftest equals-8787AF-103
  (t.= 103 (hex->8bit "#8787AF")
       "#8787AF should equal 103"))
(deftest equals-8787D7-104
  (t.= 104 (hex->8bit "#8787D7")
       "#8787D7 should equal 104"))
(deftest equals-8787FF-105
  (t.= 105 (hex->8bit "#8787FF")
       "#8787FF should equal 105"))
(deftest equals-87AF00-106
  (t.= 106 (hex->8bit "#87AF00")
       "#87AF00 should equal 106"))
(deftest equals-87AF5F-107
  (t.= 107 (hex->8bit "#87AF5F")
       "#87AF5F should equal 107"))
(deftest equals-87AF87-108
  (t.= 108 (hex->8bit "#87AF87")
       "#87AF87 should equal 108"))
(deftest equals-87AFAF-109
  (t.= 109 (hex->8bit "#87AFAF")
       "#87AFAF should equal 109"))
(deftest equals-87AFD7-110
  (t.= 110 (hex->8bit "#87AFD7")
       "#87AFD7 should equal 110"))
(deftest equals-87AFFF-111
  (t.= 111 (hex->8bit "#87AFFF")
       "#87AFFF should equal 111"))
(deftest equals-87D700-112
  (t.= 112 (hex->8bit "#87D700")
       "#87D700 should equal 112"))
(deftest equals-87D75F-113
  (t.= 113 (hex->8bit "#87D75F")
       "#87D75F should equal 113"))
(deftest equals-87D787-114
  (t.= 114 (hex->8bit "#87D787")
       "#87D787 should equal 114"))
(deftest equals-87D7AF-115
  (t.= 115 (hex->8bit "#87D7AF")
       "#87D7AF should equal 115"))
(deftest equals-87D7D7-116
  (t.= 116 (hex->8bit "#87D7D7")
       "#87D7D7 should equal 116"))
(deftest equals-87D7FF-117
  (t.= 117 (hex->8bit "#87D7FF")
       "#87D7FF should equal 117"))
(deftest equals-87FF00-118
  (t.= 118 (hex->8bit "#87FF00")
       "#87FF00 should equal 118"))
(deftest equals-87FF5F-119
  (t.= 119 (hex->8bit "#87FF5F")
       "#87FF5F should equal 119"))
(deftest equals-87FF87-120
  (t.= 120 (hex->8bit "#87FF87")
       "#87FF87 should equal 120"))
(deftest equals-87FFAF-121
  (t.= 121 (hex->8bit "#87FFAF")
       "#87FFAF should equal 121"))
(deftest equals-87FFD7-122
  (t.= 122 (hex->8bit "#87FFD7")
       "#87FFD7 should equal 122"))
(deftest equals-87FFFF-123
  (t.= 123 (hex->8bit "#87FFFF")
       "#87FFFF should equal 123"))
(deftest equals-AF0000-124
  (t.= 124 (hex->8bit "#AF0000")
       "#AF0000 should equal 124"))
(deftest equals-AF005F-125
  (t.= 125 (hex->8bit "#AF005F")
       "#AF005F should equal 125"))
(deftest equals-AF0087-126
  (t.= 126 (hex->8bit "#AF0087")
       "#AF0087 should equal 126"))
(deftest equals-AF00AF-127
  (t.= 127 (hex->8bit "#AF00AF")
       "#AF00AF should equal 127"))
(deftest equals-AF00D7-128
  (t.= 128 (hex->8bit "#AF00D7")
       "#AF00D7 should equal 128"))
(deftest equals-AF00FF-129
  (t.= 129 (hex->8bit "#AF00FF")
       "#AF00FF should equal 129"))
(deftest equals-AF5F00-130
  (t.= 130 (hex->8bit "#AF5F00")
       "#AF5F00 should equal 130"))
(deftest equals-AF5F5F-131
  (t.= 131 (hex->8bit "#AF5F5F")
       "#AF5F5F should equal 131"))
(deftest equals-AF5F87-132
  (t.= 132 (hex->8bit "#AF5F87")
       "#AF5F87 should equal 132"))
(deftest equals-AF5FAF-133
  (t.= 133 (hex->8bit "#AF5FAF")
       "#AF5FAF should equal 133"))
(deftest equals-AF5FD7-134
  (t.= 134 (hex->8bit "#AF5FD7")
       "#AF5FD7 should equal 134"))
(deftest equals-AF5FFF-135
  (t.= 135 (hex->8bit "#AF5FFF")
       "#AF5FFF should equal 135"))
(deftest equals-AF8700-136
  (t.= 136 (hex->8bit "#AF8700")
       "#AF8700 should equal 136"))
(deftest equals-AF875F-137
  (t.= 137 (hex->8bit "#AF875F")
       "#AF875F should equal 137"))
(deftest equals-AF8787-138
  (t.= 138 (hex->8bit "#AF8787")
       "#AF8787 should equal 138"))
(deftest equals-AF87AF-139
  (t.= 139 (hex->8bit "#AF87AF")
       "#AF87AF should equal 139"))
(deftest equals-AF87D7-140
  (t.= 140 (hex->8bit "#AF87D7")
       "#AF87D7 should equal 140"))
(deftest equals-AF87FF-141
  (t.= 141 (hex->8bit "#AF87FF")
       "#AF87FF should equal 141"))
(deftest equals-AFAF00-142
  (t.= 142 (hex->8bit "#AFAF00")
       "#AFAF00 should equal 142"))
(deftest equals-AFAF5F-143
  (t.= 143 (hex->8bit "#AFAF5F")
       "#AFAF5F should equal 143"))
(deftest equals-AFAF87-144
  (t.= 144 (hex->8bit "#AFAF87")
       "#AFAF87 should equal 144"))
(deftest equals-AFAFAF-145
  (t.= 145 (hex->8bit "#AFAFAF")
       "#AFAFAF should equal 145"))
(deftest equals-AFAFD7-146
  (t.= 146 (hex->8bit "#AFAFD7")
       "#AFAFD7 should equal 146"))
(deftest equals-AFAFFF-147
  (t.= 147 (hex->8bit "#AFAFFF")
       "#AFAFFF should equal 147"))
(deftest equals-AFD700-148
  (t.= 148 (hex->8bit "#AFD700")
       "#AFD700 should equal 148"))
(deftest equals-AFD75F-149
  (t.= 149 (hex->8bit "#AFD75F")
       "#AFD75F should equal 149"))
(deftest equals-AFD787-150
  (t.= 150 (hex->8bit "#AFD787")
       "#AFD787 should equal 150"))
(deftest equals-AFD7AF-151
  (t.= 151 (hex->8bit "#AFD7AF")
       "#AFD7AF should equal 151"))
(deftest equals-AFD7D7-152
  (t.= 152 (hex->8bit "#AFD7D7")
       "#AFD7D7 should equal 152"))
(deftest equals-AFD7FF-153
  (t.= 153 (hex->8bit "#AFD7FF")
       "#AFD7FF should equal 153"))
(deftest equals-AFFF00-154
  (t.= 154 (hex->8bit "#AFFF00")
       "#AFFF00 should equal 154"))
(deftest equals-AFFF5F-155
  (t.= 155 (hex->8bit "#AFFF5F")
       "#AFFF5F should equal 155"))
(deftest equals-AFFF87-156
  (t.= 156 (hex->8bit "#AFFF87")
       "#AFFF87 should equal 156"))
(deftest equals-AFFFAF-157
  (t.= 157 (hex->8bit "#AFFFAF")
       "#AFFFAF should equal 157"))
(deftest equals-AFFFD7-158
  (t.= 158 (hex->8bit "#AFFFD7")
       "#AFFFD7 should equal 158"))
(deftest equals-AFFFFF-159
  (t.= 159 (hex->8bit "#AFFFFF")
       "#AFFFFF should equal 159"))
(deftest equals-D70000-160
  (t.= 160 (hex->8bit "#D70000")
       "#D70000 should equal 160"))
(deftest equals-D7005F-161
  (t.= 161 (hex->8bit "#D7005F")
       "#D7005F should equal 161"))
(deftest equals-D70087-162
  (t.= 162 (hex->8bit "#D70087")
       "#D70087 should equal 162"))
(deftest equals-D700AF-163
  (t.= 163 (hex->8bit "#D700AF")
       "#D700AF should equal 163"))
(deftest equals-D700D7-164
  (t.= 164 (hex->8bit "#D700D7")
       "#D700D7 should equal 164"))
(deftest equals-D700FF-165
  (t.= 165 (hex->8bit "#D700FF")
       "#D700FF should equal 165"))
(deftest equals-D75F00-166
  (t.= 166 (hex->8bit "#D75F00")
       "#D75F00 should equal 166"))
(deftest equals-D75F5F-167
  (t.= 167 (hex->8bit "#D75F5F")
       "#D75F5F should equal 167"))
(deftest equals-D75F87-168
  (t.= 168 (hex->8bit "#D75F87")
       "#D75F87 should equal 168"))
(deftest equals-D75FAF-169
  (t.= 169 (hex->8bit "#D75FAF")
       "#D75FAF should equal 169"))
(deftest equals-D75FD7-170
  (t.= 170 (hex->8bit "#D75FD7")
       "#D75FD7 should equal 170"))
(deftest equals-D75FFF-171
  (t.= 171 (hex->8bit "#D75FFF")
       "#D75FFF should equal 171"))
(deftest equals-D78700-172
  (t.= 172 (hex->8bit "#D78700")
       "#D78700 should equal 172"))
(deftest equals-D7875F-173
  (t.= 173 (hex->8bit "#D7875F")
       "#D7875F should equal 173"))
(deftest equals-D78787-174
  (t.= 174 (hex->8bit "#D78787")
       "#D78787 should equal 174"))
(deftest equals-D787AF-175
  (t.= 175 (hex->8bit "#D787AF")
       "#D787AF should equal 175"))
(deftest equals-D787D7-176
  (t.= 176 (hex->8bit "#D787D7")
       "#D787D7 should equal 176"))
(deftest equals-D787FF-177
  (t.= 177 (hex->8bit "#D787FF")
       "#D787FF should equal 177"))
(deftest equals-D7AF00-178
  (t.= 178 (hex->8bit "#D7AF00")
       "#D7AF00 should equal 178"))
(deftest equals-D7AF5F-179
  (t.= 179 (hex->8bit "#D7AF5F")
       "#D7AF5F should equal 179"))
(deftest equals-D7AF87-180
  (t.= 180 (hex->8bit "#D7AF87")
       "#D7AF87 should equal 180"))
(deftest equals-D7AFAF-181
  (t.= 181 (hex->8bit "#D7AFAF")
       "#D7AFAF should equal 181"))
(deftest equals-D7AFD7-182
  (t.= 182 (hex->8bit "#D7AFD7")
       "#D7AFD7 should equal 182"))
(deftest equals-D7AFFF-183
  (t.= 183 (hex->8bit "#D7AFFF")
       "#D7AFFF should equal 183"))
(deftest equals-D7D700-184
  (t.= 184 (hex->8bit "#D7D700")
       "#D7D700 should equal 184"))
(deftest equals-D7D75F-185
  (t.= 185 (hex->8bit "#D7D75F")
       "#D7D75F should equal 185"))
(deftest equals-D7D787-186
  (t.= 186 (hex->8bit "#D7D787")
       "#D7D787 should equal 186"))
(deftest equals-D7D7AF-187
  (t.= 187 (hex->8bit "#D7D7AF")
       "#D7D7AF should equal 187"))
(deftest equals-D7D7D7-188
  (t.= 188 (hex->8bit "#D7D7D7")
       "#D7D7D7 should equal 188"))
(deftest equals-D7D7FF-189
  (t.= 189 (hex->8bit "#D7D7FF")
       "#D7D7FF should equal 189"))
(deftest equals-D7FF00-190
  (t.= 190 (hex->8bit "#D7FF00")
       "#D7FF00 should equal 190"))
(deftest equals-D7FF5F-191
  (t.= 191 (hex->8bit "#D7FF5F")
       "#D7FF5F should equal 191"))
(deftest equals-D7FF87-192
  (t.= 192 (hex->8bit "#D7FF87")
       "#D7FF87 should equal 192"))
(deftest equals-D7FFAF-193
  (t.= 193 (hex->8bit "#D7FFAF")
       "#D7FFAF should equal 193"))
(deftest equals-D7FFD7-194
  (t.= 194 (hex->8bit "#D7FFD7")
       "#D7FFD7 should equal 194"))
(deftest equals-D7FFFF-195
  (t.= 195 (hex->8bit "#D7FFFF")
       "#D7FFFF should equal 195"))
(deftest equals-FF0000-196
  (t.= 196 (hex->8bit "#FF0000")
       "#FF0000 should equal 196"))
(deftest equals-FF005F-197
  (t.= 197 (hex->8bit "#FF005F")
       "#FF005F should equal 197"))
(deftest equals-FF0087-198
  (t.= 198 (hex->8bit "#FF0087")
       "#FF0087 should equal 198"))
(deftest equals-FF00AF-199
  (t.= 199 (hex->8bit "#FF00AF")
       "#FF00AF should equal 199"))
(deftest equals-FF00D7-200
  (t.= 200 (hex->8bit "#FF00D7")
       "#FF00D7 should equal 200"))
(deftest equals-FF00FF-201
  (t.= 201 (hex->8bit "#FF00FF")
       "#FF00FF should equal 201"))
(deftest equals-FF5F00-202
  (t.= 202 (hex->8bit "#FF5F00")
       "#FF5F00 should equal 202"))
(deftest equals-FF5F5F-203
  (t.= 203 (hex->8bit "#FF5F5F")
       "#FF5F5F should equal 203"))
(deftest equals-FF5F87-204
  (t.= 204 (hex->8bit "#FF5F87")
       "#FF5F87 should equal 204"))
(deftest equals-FF5FAF-205
  (t.= 205 (hex->8bit "#FF5FAF")
       "#FF5FAF should equal 205"))
(deftest equals-FF5FD7-206
  (t.= 206 (hex->8bit "#FF5FD7")
       "#FF5FD7 should equal 206"))
(deftest equals-FF5FFF-207
  (t.= 207 (hex->8bit "#FF5FFF")
       "#FF5FFF should equal 207"))
(deftest equals-FF8700-208
  (t.= 208 (hex->8bit "#FF8700")
       "#FF8700 should equal 208"))
(deftest equals-FF875F-209
  (t.= 209 (hex->8bit "#FF875F")
       "#FF875F should equal 209"))
(deftest equals-FF8787-210
  (t.= 210 (hex->8bit "#FF8787")
       "#FF8787 should equal 210"))
(deftest equals-FF87AF-211
  (t.= 211 (hex->8bit "#FF87AF")
       "#FF87AF should equal 211"))
(deftest equals-FF87D7-212
  (t.= 212 (hex->8bit "#FF87D7")
       "#FF87D7 should equal 212"))
(deftest equals-FF87FF-213
  (t.= 213 (hex->8bit "#FF87FF")
       "#FF87FF should equal 213"))
(deftest equals-FFAF00-214
  (t.= 214 (hex->8bit "#FFAF00")
       "#FFAF00 should equal 214"))
(deftest equals-FFAF5F-215
  (t.= 215 (hex->8bit "#FFAF5F")
       "#FFAF5F should equal 215"))
(deftest equals-FFAF87-216
  (t.= 216 (hex->8bit "#FFAF87")
       "#FFAF87 should equal 216"))
(deftest equals-FFAFAF-217
  (t.= 217 (hex->8bit "#FFAFAF")
       "#FFAFAF should equal 217"))
(deftest equals-FFAFD7-218
  (t.= 218 (hex->8bit "#FFAFD7")
       "#FFAFD7 should equal 218"))
(deftest equals-FFAFFF-219
  (t.= 219 (hex->8bit "#FFAFFF")
       "#FFAFFF should equal 219"))
(deftest equals-FFD700-220
  (t.= 220 (hex->8bit "#FFD700")
       "#FFD700 should equal 220"))
(deftest equals-FFD75F-221
  (t.= 221 (hex->8bit "#FFD75F")
       "#FFD75F should equal 221"))
(deftest equals-FFD787-222
  (t.= 222 (hex->8bit "#FFD787")
       "#FFD787 should equal 222"))
(deftest equals-FFD7AF-223
  (t.= 223 (hex->8bit "#FFD7AF")
       "#FFD7AF should equal 223"))
(deftest equals-FFD7D7-224
  (t.= 224 (hex->8bit "#FFD7D7")
       "#FFD7D7 should equal 224"))
(deftest equals-FFD7FF-225
  (t.= 225 (hex->8bit "#FFD7FF")
       "#FFD7FF should equal 225"))
(deftest equals-FFFF00-226
  (t.= 226 (hex->8bit "#FFFF00")
       "#FFFF00 should equal 226"))
(deftest equals-FFFF5F-227
  (t.= 227 (hex->8bit "#FFFF5F")
       "#FFFF5F should equal 227"))
(deftest equals-FFFF87-228
  (t.= 228 (hex->8bit "#FFFF87")
       "#FFFF87 should equal 228"))
(deftest equals-FFFFAF-229
  (t.= 229 (hex->8bit "#FFFFAF")
       "#FFFFAF should equal 229"))
(deftest equals-FFFFD7-230
  (t.= 230 (hex->8bit "#FFFFD7")
       "#FFFFD7 should equal 230"))
(deftest equals-FFFFFF-231
  (t.= 231 (hex->8bit "#FFFFFF")
       "#FFFFFF should equal 231"))
(deftest equals-080808-232
  (t.= 232 (hex->8bit "#080808")
       "#080808 should equal 232"))
(deftest equals-121212-233
  (t.= 233 (hex->8bit "#121212")
       "#121212 should equal 233"))
(deftest equals-1C1C1C-234
  (t.= 234 (hex->8bit "#1C1C1C")
       "#1C1C1C should equal 234"))
(deftest equals-262626-235
  (t.= 235 (hex->8bit "#262626")
       "#262626 should equal 235"))
(deftest equals-303030-236
  (t.= 236 (hex->8bit "#303030")
       "#303030 should equal 236"))
(deftest equals-3A3A3A-237
  (t.= 237 (hex->8bit "#3A3A3A")
       "#3A3A3A should equal 237"))
(deftest equals-444444-238
  (t.= 238 (hex->8bit "#444444")
       "#444444 should equal 238"))
(deftest equals-4E4E4E-239
  (t.= 239 (hex->8bit "#4E4E4E")
       "#4E4E4E should equal 239"))
(deftest equals-585858-240
  (t.= 240 (hex->8bit "#585858")
       "#585858 should equal 240"))
(deftest equals-626262-241
  (t.= 241 (hex->8bit "#626262")
       "#626262 should equal 241"))
(deftest equals-6C6C6C-242
  (t.= 242 (hex->8bit "#6C6C6C")
       "#6C6C6C should equal 242"))
(deftest equals-767676-243
  (t.= 243 (hex->8bit "#767676")
       "#767676 should equal 243"))
(deftest equals-808080-244
  (t.= 244 (hex->8bit "#808080")
       "#808080 should equal 244"))
(deftest equals-8A8A8A-245
  (t.= 245 (hex->8bit "#8A8A8A")
       "#8A8A8A should equal 245"))
(deftest equals-949494-246
  (t.= 246 (hex->8bit "#949494")
       "#949494 should equal 246"))
(deftest equals-9E9E9E-247
  (t.= 247 (hex->8bit "#9E9E9E")
       "#9E9E9E should equal 247"))
(deftest equals-A8A8A8-248
  (t.= 248 (hex->8bit "#A8A8A8")
       "#A8A8A8 should equal 248"))
(deftest equals-B2B2B2-249
  (t.= 249 (hex->8bit "#B2B2B2")
       "#B2B2B2 should equal 249"))
(deftest equals-BCBCBC-250
  (t.= 250 (hex->8bit "#BCBCBC")
       "#BCBCBC should equal 250"))
(deftest equals-C6C6C6-251
  (t.= 251 (hex->8bit "#C6C6C6")
       "#C6C6C6 should equal 251"))
(deftest equals-D0D0D0-252
  (t.= 252 (hex->8bit "#D0D0D0")
       "#D0D0D0 should equal 252"))
(deftest equals-DADADA-253
  (t.= 253 (hex->8bit "#DADADA")
       "#DADADA should equal 253"))
(deftest equals-E4E4E4-254
  (t.= 254 (hex->8bit "#E4E4E4")
       "#E4E4E4 should equal 254"))
(deftest equals-EEEEEE-255
  (t.= 255 (hex->8bit "#EEEEEE")
       "#EEEEEE should equal 255"))
