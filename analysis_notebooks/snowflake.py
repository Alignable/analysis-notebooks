"""Shared Snowflake connection helper.

Usage:
    from analysis_notebooks.snowflake import connect
    conn = connect()
    cursor = conn.cursor()

The connecting user is resolved from ``$SNOWFLAKE_USER`` if set, otherwise
from ``git config user.email``. All other parameters have shared defaults
and can be overridden per-call (e.g. ``connect(schema="OTHER_SCHEMA")``).
"""
from __future__ import annotations

import os
import subprocess

import snowflake.connector

REQUIRED_USER_DOMAIN = "@alignable.com"

DEFAULT_PARAMS = {
    "account": "HOFEOUE-CPB80774",
    "authenticator": "externalbrowser",
    "role": "DEVELOPMENT_ROLE",
    "warehouse": "DEV_SMALL",
    "database": "ALIGNABLE_REPORTING",
    "schema": "EVENT_STREAMS",
    "paramstyle": "qmark",
}


def _resolve_user() -> str:
    if env_user := os.environ.get("SNOWFLAKE_USER"):
        return env_user
    try:
        result = subprocess.run(
            ["git", "config", "user.email"],
            capture_output=True,
            text=True,
            check=True,
        )
    except (subprocess.CalledProcessError, FileNotFoundError) as exc:
        raise RuntimeError(
            "Could not resolve Snowflake user: set $SNOWFLAKE_USER or "
            "configure git user.email."
        ) from exc
    email = result.stdout.strip()
    if not email:
        raise RuntimeError(
            "Could not resolve Snowflake user: $SNOWFLAKE_USER is unset and "
            "git config user.email is empty."
        )
    if not email.lower().endswith(REQUIRED_USER_DOMAIN):
        raise RuntimeError(
            f"git config user.email is {email!r}, which is not an "
            f"{REQUIRED_USER_DOMAIN} address. Set $SNOWFLAKE_USER to your "
            f"Alignable email to override."
        )
    return email.upper()


def connect(**overrides):
    params = {**DEFAULT_PARAMS, "user": _resolve_user(), **overrides}
    return snowflake.connector.connect(**params)