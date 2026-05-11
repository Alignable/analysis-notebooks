import os
from pathlib import Path

from dotenv import load_dotenv

load_dotenv(Path(__file__).parent / ".env.local")

HAIKU_PROFILE = os.environ["HAIKU_PROFILE"]
SONNET_PROFILE = os.environ["SONNET_PROFILE"]
OPUS_PROFILE = os.environ["OPUS_PROFILE"]

class Helpers:
	# Pricing per 1M tokens (on-demand Bedrock rates — verify at aws.amazon.com/bedrock/pricing)
	PRICING = {
			HAIKU_PROFILE:                               {"input": 0.80,  "output": 4.00},
			SONNET_PROFILE: 														 {"input": 3.00, "output": 15.00},
			OPUS_PROFILE:																 {"input": 5.00, "output": 25.00},
			"amazon.titan-embed-text-v2:0":              {"input": 0.02},
	}

	