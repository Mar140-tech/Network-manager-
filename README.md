<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Network Manager - Admin Protection</title>
    <link rel="manifest" href="manifest.json">
    <style>
        :root {
            --primary: #2563eb;
            --success: #16a34a;
            --warning: #d97706;
            --danger: #dc2626;
            --info: #0891b2;
            --purple: #7c3aed;
            --cyan: #06b6d4;
            --orange: #ea580c;
            --teal: #0d9488;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #1e293b;
        }
        
        .app-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 1rem;
            min-height: 100vh;
        }
        
        .app-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1.5rem;
            border-radius: 20px;
            margin-bottom: 1rem;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        }
        
        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .admin-badge {
            display: inline-block;
            background: linear-gradient(135deg, var(--purple), var(--primary));
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        .emergency-unblock {
            background: linear-gradient(135deg, var(--danger), var(--orange));
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.3s ease;
        }
        
        .emergency-unblock:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 1.5rem;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: #64748b;
        }
        
        .action-bar {
            background: rgba(255, 255, 255, 0.95);
            padding: 1.5rem;
            border-radius: 16px;
            margin-bottom: 1rem;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
        }
        
        .devices-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        @media (max-width: 768px) {
            .devices-grid {
                grid-template-columns: 1fr;
            }
        }
        
        .device-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .device-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0,0,0,0.15);
        }
        
        .device-card.admin {
            background: linear-gradient(135deg, rgba(255,255,255,0.95), rgba(124, 58, 237, 0.1));
            border: 2px solid var(--purple);
        }
        
        .device-card.admin-blocked {
            background: linear-gradient(135deg, rgba(255,255,255,0.9), rgba(220, 38, 38, 0.15));
            border: 2px solid var(--danger);
            animation: pulse-alert 2s infinite;
        }
        
        .device-card.offline {
            opacity: 0.7;
            background: rgba(255, 255, 255, 0.8);
        }
        
        .device-card.blocked {
            background: linear-gradient(135deg, rgba(255,255,255,0.9), rgba(220, 38, 38, 0.1));
            border: 2px solid var(--danger);
        }
        
        .device-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f1f5f9;
        }
        
        .device-info {
            flex: 1;
        }
        
        .device-title {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.5rem;
        }
        
        .device-type {
            font-size: 1.5rem;
        }
        
        .device-name {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1e293b;
        }
        
        .device-status {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }
        
        .badge-online {
            background: var(--success);
            color: white;
        }
        
        .badge-offline {
            background: var(--danger);
            color: white;
        }
        
        .badge-admin {
            background: linear-gradient(135deg, var(--purple), var(--primary));
            color: white;
        }
        
        .badge-admin-blocked {
            background: linear-gradient(135deg, var(--danger), var(--orange));
            color: white;
            animation: pulse-alert 2s infinite;
        }
        
        .badge-blocked {
            background: var(--danger);
            color: white;
        }
        
        .badge-limited {
            background: var(--warning);
            color: white;
        }
        
        .badge-unlimited {
            background: var(--success);
            color: white;
        }
        
        .device-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }
        
        .detail-item {
            display: flex;
            flex-direction: column;
        }
        
        .detail-label {
            font-size: 0.8rem;
            color: #64748b;
            margin-bottom: 0.2rem;
        }
        
        .detail-value {
            font-weight: 600;
            color: #1e293b;
            font-family: 'Monaco', 'Consolas', monospace;
        }
        
        .bandwidth-section {
            background: rgba(255, 255, 255, 0.8);
            padding: 1.25rem;
            border-radius: 16px;
            margin-bottom: 1.5rem;
            border: 2px solid #f1f5f9;
        }
        
        .bandwidth-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .bandwidth-title {
            font-weight: 700;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .current-limit {
            font-weight: 700;
            color: var(--primary);
            font-size: 1.1rem;
        }
        
        .admin-warning {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            border: 2px solid #f59e0b;
            border-radius: 12px;
            padding: 1rem;
            margin: 1rem 0;
            text-align: center;
        }
        
        .admin-warning h4 {
            color: #92400e;
            margin-bottom: 0.5rem;
        }
        
        .admin-warning p {
            color: #92400e;
            font-size: 0.9rem;
        }
        
        .bandwidth-controls {
            margin-bottom: 1rem;
        }
        
        .slider-container {
            margin: 1rem 0;
        }
        
        .slider-labels {
            display: flex;
            justify-content: space-between;
            margin-top: 0.5rem;
            font-size: 0.8rem;
            color: #64748b;
        }
        
        .bandwidth-presets {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0.5rem;
            margin-top: 1rem;
        }
        
        .preset-btn {
            padding: 0.6rem 0.5rem;
            border: 2px solid var(--primary);
            background: transparent;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .preset-btn:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-1px);
        }
        
        .preset-btn.active {
            background: var(--primary);
            color: white;
        }
        
        .preset-btn.unlimited {
            border-color: var(--success);
        }
        
        .preset-btn.unlimited.active {
            background: var(--success);
            color: white;
        }
        
        .preset-btn.block {
            border-color: var(--danger);
        }
        
        .preset-btn.block.active {
            background: var(--danger);
            color: white;
        }
        
        .preset-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }
        
        .preset-btn:disabled:hover {
            background: transparent;
            color: inherit;
        }
        
        .usage-meter {
            margin-top: 1rem;
        }
        
        .usage-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        
        .usage-bar {
            height: 8px;
            background: #e2e8f0;
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 0.5rem;
        }
        
        .usage-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--success), var(--warning), var(--danger));
            border-radius: 4px;
            transition: width 0.3s ease;
            width: 0%;
        }
        
        .usage-stats {
            display: flex;
            justify-content: space-between;
            font-size: 0.8rem;
            color: #64748b;
        }
        
        .device-actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 0.75rem 1.25rem;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 0.85rem;
            font-weight: 600;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            flex: 1;
            justify-content: center;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .btn-primary { 
            background: var(--primary); 
            color: white; 
        }
        
        .btn-success { 
            background: var(--success); 
            color: white; 
        }
        
        .btn-warning { 
            background: var(--warning); 
            color: white; 
        }
        
        .btn-danger { 
            background: var(--danger); 
            color: white; 
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid var(--primary);
            color: var(--primary);
        }
        
        .btn-group {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        input[type="range"] {
            width: 100%;
            height: 6px;
            border-radius: 3px;
            background: #e2e8f0;
            outline: none;
            -webkit-appearance: none;
        }
        
        input[type="range"]::-webkit-slider-thumb {
            -webkit-appearance: none;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            background: var(--primary);
            cursor: pointer;
            border: 3px solid white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }
        
        input[type="range"]:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        input[type="range"]:disabled::-webkit-slider-thumb {
            background: #94a3b8;
            cursor: not-allowed;
        }
        
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #64748b;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            margin: 2rem 0;
        }
        
        .loading {
            opacity: 0.7;
            pointer-events: none;
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        
        @keyframes pulse-alert {
            0% { opacity: 1; }
            50% { opacity: 0.7; }
            100% { opacity: 1; }
        }
        
        .traffic-graph {
            height: 40px;
            background: rgba(255,255,255,0.5);
            border-radius: 8px;
            margin: 0.5rem 0;
            position: relative;
            overflow: hidden;
        }
        
        .traffic-bar {
            position: absolute;
            bottom: 0;
            width: 3px;
            background: var(--primary);
            border-radius: 2px 2px 0 0;
            transition: height 0.3s ease;
        }
        
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            backdrop-filter: blur(5px);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal-content {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            max-width: 500px;
            width: 90%;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        
        .modal-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            justify-content: center;
        }
    </style>
</head>
<body>
    <div class="app-container">
        <div class="app-header">
            <div class="header-top">
                <div>
                    <h1>🌐 Network Manager</h1>
                    <p>Admin Device Protection & Bandwidth Control</p>
                </div>
                <div>
                    <div class="admin-badge">👑 ADMIN CONTROLLER</div>
                    <button class="emergency-unblock" onclick="manager.showEmergencyUnblockModal()" style="margin-top: 0.5rem;">
                        🚨 Emergency Unblock Admin
                    </button>
                </div>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number" id="totalDevices">0</div>
                    <div class="stat-label">Total Devices</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="onlineDevices">0</div>
                    <div class="stat-label">Online Now</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="bandwidthManaged">0</div>
                    <div class="stat-label">Mbps Managed</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="blockedDevices">0</div>
                    <div class="stat-label">Blocked</div>
                </div>
            </div>
        </div>

        <div class="action-bar">
            <div class="btn-group">
                <button class="btn btn-primary" onclick="manager.scanNetwork()" id="scanBtn">
                    <span>🔍</span> Scan Network
                </button>
                <button class="btn btn-success" onclick="manager.startMonitoring()" id="monitorBtn">
                    <span>📡</span> Start Monitoring
                </button>
                <button class="btn btn-warning" onclick="manager.applyGlobalLimit(5)">
                    <span>🌍</span> Set All to 5Mbps
                </button>
                <button class="btn btn-outline" onclick="manager.addTestDevice()">
                    <span>➕</span> Add Test Device
                </button>
                <button class="btn btn-outline" onclick="manager.exportData()">
                    <span>📤</span> Export Data
                </button>
            </div>
        </div>

        <div id="devicesContainer">
            <!-- All devices will be loaded here in grid layout -->
        </div>
    </div>

    <!-- Emergency Unblock Modal -->
    <div id="emergencyModal" class="modal">
        <div class="modal-content">
            <h2>🚨 Emergency Admin Unblock</h2>
            <p>Your admin device appears to be blocked. This should never happen, but if it does, you can use this emergency unblock feature.</p>
            <p><strong>Note:</strong> Admin devices should automatically be protected from blocking.</p>
            <div class="modal-buttons">
                <button class="btn btn-danger" onclick="manager.emergencyUnblockAdmin()">
                    🔓 Force Unblock Admin
                </button>
                <button class="btn btn-outline" onclick="manager.hideEmergencyUnblockModal()">
                    Cancel
                </button>
            </div>
        </div>
    </div>

    <script>
        class NetworkManager {
            constructor() {
                this.devices = this.loadFromStorage();
                this.monitoring = false;
                this.monitorInterval = null;
                this.myDevice = null;
                this.init();
            }
            
            async init() {
                await this.identifyMyDevice();
                this.ensureAdminProtection(); // Ensure admin is never blocked
                this.renderStats();
                this.renderAllDevices();
                this.startMonitoring();
                console.log('🚀 Network Manager with Admin Protection initialized');
            }

            // ADMIN PROTECTION METHODS
            ensureAdminProtection() {
                const adminDevice = this.devices
