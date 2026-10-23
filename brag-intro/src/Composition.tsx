import { loadFont } from "@remotion/fonts";
import {
  AbsoluteFill,
  Composition,
  Easing,
  interpolate,
  random,
  spring,
  staticFile,
  useCurrentFrame,
  useVideoConfig,
} from "remotion";

// Fonts are bundled locally in public/fonts (SIL Open Font License)
const serif = "Cinzel";
const sans = "Montserrat";
loadFont({
  family: serif,
  url: staticFile("fonts/cinzel-latin-600-normal.woff2"),
  weight: "600",
});
loadFont({
  family: sans,
  url: staticFile("fonts/montserrat-latin-300-normal.woff2"),
  weight: "300",
});

const FPS = 30;
const DURATION = 10 * FPS;

const BG = "#07070a";
const GOLD = "#d4af37";
const GOLD_LIGHT = "#f5e2a1";
const GOLD_DARK = "#8a6a1f";

const TITLE = "BRAG";
const WEBSITE = "lunacaram.com";

export const MyComposition = () => {
  return (
    <Composition
      id="BragIntro"
      component={BragIntro}
      durationInFrames={DURATION}
      fps={FPS}
      width={1920}
      height={1080}
    />
  );
};

const clamp = {
  extrapolateLeft: "clamp",
  extrapolateRight: "clamp",
} as const;

const Particles: React.FC = () => {
  const frame = useCurrentFrame();
  const { width, height } = useVideoConfig();

  return (
    <AbsoluteFill>
      {new Array(70).fill(true).map((_, i) => {
        const x = random(`x-${i}`) * width;
        const startY = random(`y-${i}`) * height;
        const speed = 0.3 + random(`s-${i}`) * 0.9;
        const size = 1.5 + random(`r-${i}`) * 3.5;
        const y = (startY - frame * speed + height) % height;
        const twinkle =
          0.35 + 0.65 * Math.abs(Math.sin(frame / 18 + random(`t-${i}`) * 10));
        const fadeIn = interpolate(frame, [0, 40], [0, 1], clamp);
        return (
          <div
            key={i}
            style={{
              position: "absolute",
              left: x,
              top: y,
              width: size,
              height: size,
              borderRadius: "50%",
              background: GOLD_LIGHT,
              boxShadow: `0 0 ${size * 4}px ${GOLD}`,
              opacity: twinkle * fadeIn * 0.7,
            }}
          />
        );
      })}
    </AbsoluteFill>
  );
};

const Glow: React.FC = () => {
  const frame = useCurrentFrame();
  const intensity = interpolate(frame, [20, 110], [0, 1], {
    ...clamp,
    easing: Easing.out(Easing.cubic),
  });
  const pulse = 1 + Math.sin(frame / 25) * 0.04;
  return (
    <AbsoluteFill
      style={{
        background: `radial-gradient(ellipse ${55 * pulse}% ${45 * pulse}% at 50% 48%, rgba(212,175,55,${
          0.22 * intensity
        }) 0%, rgba(212,175,55,0) 70%)`,
      }}
    />
  );
};

const GoldLine: React.FC<{ y: number; delay: number }> = ({ y, delay }) => {
  const frame = useCurrentFrame();
  const progress = interpolate(frame, [delay, delay + 45], [0, 1], {
    ...clamp,
    easing: Easing.inOut(Easing.cubic),
  });
  return (
    <div
      style={{
        position: "absolute",
        top: y,
        left: "50%",
        width: 900 * progress,
        height: 2,
        transform: "translateX(-50%)",
        background: `linear-gradient(90deg, transparent, ${GOLD} 20%, ${GOLD_LIGHT} 50%, ${GOLD} 80%, transparent)`,
        boxShadow: `0 0 18px ${GOLD}`,
      }}
    />
  );
};

const Title: React.FC = () => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  // Light sweep across the letters after they landed
  const sweep = interpolate(frame, [130, 200], [-40, 140], clamp);

  return (
    <div
      style={{
        display: "flex",
        gap: 40,
        fontFamily: serif,
        fontWeight: 600,
        fontSize: 300,
        lineHeight: 1,
        letterSpacing: 10,
      }}
    >
      {TITLE.split("").map((char, i) => {
        const delay = 45 + i * 10;
        const s = spring({
          frame: frame - delay,
          fps,
          config: { damping: 200 },
          durationInFrames: 40,
        });
        const blur = interpolate(s, [0, 1], [24, 0]);
        return (
          <span
            key={i}
            style={{
              display: "inline-block",
              opacity: s,
              transform: `translateY(${interpolate(s, [0, 1], [60, 0])}px) scale(${interpolate(
                s,
                [0, 1],
                [1.25, 1],
              )})`,
              filter: `blur(${blur}px) drop-shadow(0 0 30px rgba(212,175,55,0.35))`,
              backgroundImage: `linear-gradient(110deg, ${GOLD_DARK} 0%, ${GOLD} ${
                sweep - 25
              }%, #fff8dc ${sweep}%, ${GOLD} ${sweep + 25}%, ${GOLD_DARK} 100%)`,
              backgroundClip: "text",
              WebkitBackgroundClip: "text",
              color: "transparent",
            }}
          >
            {char}
          </span>
        );
      })}
    </div>
  );
};

const Website: React.FC = () => {
  const frame = useCurrentFrame();
  const opacity = interpolate(frame, [165, 200], [0, 1], clamp);
  const spacing = interpolate(frame, [165, 230], [4, 18], {
    ...clamp,
    easing: Easing.out(Easing.cubic),
  });
  return (
    <div
      style={{
        fontFamily: sans,
        fontWeight: 300,
        fontSize: 44,
        letterSpacing: spacing,
        color: GOLD_LIGHT,
        opacity,
        textTransform: "lowercase",
      }}
    >
      {WEBSITE}
    </div>
  );
};

export const BragIntro: React.FC = () => {
  const frame = useCurrentFrame();
  const { durationInFrames } = useVideoConfig();

  const fadeOut = interpolate(
    frame,
    [durationInFrames - 30, durationInFrames - 1],
    [1, 0],
    clamp,
  );
  const zoom = interpolate(frame, [0, durationInFrames], [1, 1.06]);

  return (
    <AbsoluteFill style={{ backgroundColor: BG }}>
      <AbsoluteFill style={{ opacity: fadeOut, transform: `scale(${zoom})` }}>
        <Glow />
        <Particles />
        <GoldLine y={330} delay={15} />
        <GoldLine y={680} delay={140} />
        <AbsoluteFill
          style={{
            justifyContent: "center",
            alignItems: "center",
            flexDirection: "column",
            gap: 70,
            paddingTop: 60,
          }}
        >
          <Title />
          <Website />
        </AbsoluteFill>
        {/* Vignette */}
        <AbsoluteFill
          style={{
            background:
              "radial-gradient(ellipse at center, transparent 45%, rgba(0,0,0,0.85) 100%)",
          }}
        />
      </AbsoluteFill>
    </AbsoluteFill>
  );
};
